//
//  BankDetailViewController.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit
import SwiftyJSON
class BankDetailViewController: UIViewController {

    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var loanTenureLocLbl: UILabel!
    @IBOutlet weak var processngFeeLocLbl: UILabel!
    @IBOutlet weak var intRatLocLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var loanTenureLbl: UILabel!
    @IBOutlet weak var processingFeeLbl: UILabel!
    @IBOutlet weak var rateOInterest: UILabel!
    @IBOutlet weak var loanType: UILabel!
    @IBOutlet weak var bankNameLbl: UILabel!
    var id:String?
    var purposeMarrge  = [PurposeMarrige]()
    var homeLoanArray = [LoanType](){
           didSet {
               if homeLoanArray.count > 0 {
//                setupUIData()
               self.aTableView.reloadData()
               }
       }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupUIData()
        homeLoanTypeAPI(id: self.id ?? "")
    }
    var bankDetail:LoanList?
    @IBAction func applyLoanAction(_ sender: Any) {
//        openViewController(controller: LoanRequestViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
//            vc.loaninfo = self.bankDetail
//
//                 })
    }
    
    ///Bank Detail description
    func setupUIData(){
       
        self.bankNameLbl.text = self.bankDetail?.name ?? ""
//        self.loanType.text = self.bankDetail?.loanTypes[0].fr_name ?? ""
//
//        self.rateOInterest.text = "\(self.bankDetail?.interest ?? "0") %"
//        processingFeeLbl.text = "₵\(self.bankDetail?.processingFee ?? "")"
//        self.loanTenureLbl.text = "\(self.bankDetail?.min_tenure ?? "" ) Years"
//        self.descriptionLbl.text = "\(self.bankDetail?.description ?? "Testing")"
        if let imageStr = self.bankDetail?.logo{
            print(imageStr)

            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            bankImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "ino-image"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
//        if bankDetail?.description == "" || bankDetail?.description == "null" {
//            self.descriptionView.isHidden = true
//        }
//        else {
//            self.descriptionView.isHidden = false
//        }
    }
    @IBAction func openEMICalculaoatr(_ sender: Any) {
//        openViewController(controller: CalculateEMIViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
//            vc.getLoanData = self.bankDetail
//    
//                 })
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func homeLoanTypeAPI(id:String
    ) {
        let params =  [String : Any]()
//       params["lenderId"] = id
       
        AppManager.init().hudShow()
//        Common.startActivityIndicator(baseView: collctionView)
        ServiceClass.sharedInstance.hitServiceForHomeLoan(params, loanID: id, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
//            Common.stopActivityIndicator(baseView: self.collctionView)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
                self.homeLoanArray.removeAll()
                for obj in getData["products"].arrayValue {
                   let comObj = LoanType(fromJson:obj)
                    self.homeLoanArray.append(comObj)
                }
                for obj in getData["purposes"].arrayValue {
                    let cmnobj = PurposeMarrige(fromJson:obj)
                    self.purposeMarrge.append(cmnobj)
                }
                }

             else {

                guard let dicErr = errorDict?["msg"] as? String else {
                    return
                }
                Common.showAlert(alertMessage: (dicErr), alertButtons: ["Ok"]) { (bt) in
                }


            }

        })
    }
}
extension BankDetailViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeLoanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aTableView.dequeueReusableCell(withIdentifier: "LendersPropertyTableViewCell", for: indexPath) as! LendersPropertyTableViewCell
//        cell.configureCell(response: homeLoanData[indexPath.row])
        cell.calulateEMI = {[weak self]  in
                            if let strongSelf = self {
                             strongSelf.openViewController(controller: CalculateEMIViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                                 vc.getLoanData = strongSelf.homeLoanArray[indexPath.row]
                             })
     
                            }
     
     
             }
        cell.applyloanClosure = {[weak self]  in
                            if let strongSelf = self {
                                strongSelf.openViewController(controller: LoanRequestViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                                 vc.loaninfo = strongSelf.homeLoanArray[indexPath.row]
                                    vc.loanPurpose = strongSelf.purposeMarrge
                                    vc.lenderID = strongSelf.id
                             })
     
                            }
     
     
             }
        let view = UIView()
        view.backgroundColor = .clear
        cell.selectedBackgroundView = view
        cell.configureCell(response:
                            homeLoanArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openViewController(controller: LoanRequestViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
         vc.loaninfo = self.homeLoanArray[indexPath.row]
            vc.loanPurpose = self.purposeMarrge
            vc.lenderID = self.id
     })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
