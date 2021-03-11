//
//  LoanVC.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit
import SwiftyJSON
class LoanVC: UIViewController {

    @IBOutlet weak var aTableView: UITableView!
   
    var loanInfo:MyLoanDetailView?
  
    var loanSectionArray = [MyLoanSection](){
        didSet {
            
            aTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        myLoanData()
      
    }
    fileprivate func poploanInfoView(response:MyLoanList) {
        
        if loanInfo == nil {
            //               self.view.isUserInteractionEnabled = false
            loanInfo = Bundle.main.loadNibNamed("MyLoanDetailView", owner: self, options: nil)?.first as? MyLoanDetailView
            loanInfo?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            loanInfo?.confirgureCell(response: response)
            loanInfo?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.removeChangePassView()
                }
            }
            appdelegate.window?.addSubview(loanInfo!)
           
        }
        
    }
    fileprivate func removeChangePassView() {
      
        loanInfo?.removeFromSuperview()
        loanInfo = nil
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        if appdelegate.isComingFromSideMenu{
//            openViewController(controller: CalculateEMIViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
//                appdelegate.isComingFromSideMenu = false
//            })
//        }
    }
    @IBAction func showBars(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoanVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoanTableViewCell") as! LoanTableViewCell
        cell.calculateEMI.setTitleColor(.white, for: .normal)
        let view = UIView()
        view.backgroundColor = .clear
        cell.selectedBackgroundView = view
            
        if self.loanSectionArray[indexPath.section].status == "DECLINE" {
            cell.calculateEMI.isHidden = false
            cell.calculateEMI.backgroundColor = UIColor(red: 250/255, green: 50/255, blue: 59/255, alpha: 1)
            cell.calculateEMI.layer.borderColor = UIColor(red: 250/255, green: 50/255, blue: 59/255, alpha: 1).cgColor
           
        }
        else  {
        cell.calculateEMI.isHidden = true
        }
        cell.confirgureCell(response: self.loanSectionArray[indexPath.section].loans[indexPath.row])
       
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return self.loanSectionArray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.loanSectionArray[section].loans.count
                
        }
        
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
            // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
        let headerView = UIView ()
            guard let customView = Bundle.main.loadNibNamed("ContestCategoryTableHeaderView", owner: self, options: nil)?.first as? ContestCategoryTableHeaderView else  {
                return headerView
            }
            customView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 70)
            headerView.addSubview(customView)
            customView.configureCell(category: loanSectionArray[section])
            return headerView
       
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
      
            return 50
      
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        poploanInfoView(response:  self.loanSectionArray[indexPath.section].loans[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
            
                return  150
            }
            
       
        
    func showErrorOnView(message : String ,imag : UIImage? ,retry_BtnShow : Bool)
      {
          let Retry =  RetryViewController(frame: CGRect.init(x: 0, y: 0, width: self.aTableView.frame.width, height: self.aTableView.frame.height))
          Retry.lbl_message.text = message
          Retry.center_image?.image = imag
          Retry.btn_title.isHidden = !retry_BtnShow
          Retry.btn_title.setTitle("Try again", for: .normal)
          Retry.retryButtonComplition = {
              self.aTableView.backgroundView = nil
              self.viewWillAppear(false)
          }
          self.aTableView.backgroundView = Retry
      }
  
}
extension LoanVC {
    func myLoanData(){
        let params =  [String : Any]()
     
        Common.startActivityIndicator(baseView: aTableView)
        ServiceClass.self.sharedInstance.hitServiceForMyLoanData(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            Common.stopActivityIndicator(baseView: self.aTableView)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
             //                let loanType = parseData["loan_types"].stringValue
                self.loanSectionArray.removeAll()
                for obj in parseData["data"].arrayValue {
                   let comObj = MyLoanSection(fromJson:obj)
                    self.loanSectionArray.append(comObj)
                }
                if self.loanSectionArray.count < 1 {
                    self.showErrorOnView(message: "No Record Found", imag: UIImage(), retry_BtnShow: false)
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
