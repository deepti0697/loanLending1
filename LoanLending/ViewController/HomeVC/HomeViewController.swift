//
//  HomeViewController.swift
//  LoanLending
//
//  Created by deepti on 15/01/21.
//

import UIKit
import FAPanels
import SwiftyJSON
class HomeViewController: UIViewController {
    var kBarHeight:CGFloat = 80
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var allLoansLabel: UILabel!
    @IBOutlet weak var allLendersLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var collctionView: UICollectionView!
    var indexSelection = 0
//    var homeLoanArray = [LoanType](){
//        didSet {
//            if homeLoanArray.count > 0 {
//                self.homeLoanData(loanID: self.homeLoanArray[0].id)
//                }
//            self.collctionView.reloadData()
//            }
//    }
    var homeLoanData = [LoanList](){
        didSet {
            self.aTableView.reloadData()
            
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        homeLoanData(loanID: "")
        collctionView.delegate = self
        collctionView.dataSource = self
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: 125, height: 80)
              collectionLayout.minimumInteritemSpacing = 1 
        collectionLayout.scrollDirection = .horizontal
        collctionView.collectionViewLayout = collectionLayout
        homeLoanTypeAPI()
//        fatalError()
      
        
        // Do any additional setup after loading the view.
    }
    
    func setupLocalized(){
        self.allLendersLabel.text = "All Lenders".localized(lang)
        self.allLoansLabel.text = "All Loans".localized(lang)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        myUserData()
      
//        UITabBar.appearance().barTintColor = UIColor.black
        
    }
    override func viewDidAppear(_ animated: Bool) {
      
//        self.collctionView.selectItem(at: myIndexPath, animated: true, scrollPosition: .top)
    }
   
    @IBAction func openSideMenu(_ sender: Any) {
        
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
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVCCollectionViewCell", for: indexPath) as! HomeVCCollectionViewCell
           if indexSelection == indexPath.row {
               cell.loanTypeLabel.textColor =   UIColor(red: 26/155, green: 178/255, blue: 241/255, alpha: 1)
               cell.backgroundViewC?.layer.borderColor =  UIColor(red: 26/155, green: 178/255, blue: 241/255, alpha: 1).cgColor
               cell.backgroundViewC.layer.borderWidth =  2
           }
           else {
               cell.loanTypeLabel.textColor =  #colorLiteral(red: 0.5060961843, green: 0.5214104056, blue: 0.6324416399, alpha: 1)
               cell.backgroundViewC?.layer.borderColor = #colorLiteral(red: 0.5060961843, green: 0.5214104056, blue: 0.6324416399, alpha: 1)
               cell.backgroundViewC.layer.borderWidth =  0
           }
//           cell.configureCell(response: homeLoanArray[indexPath.row])
           
           return cell
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
//            self.homeLoanData(loanID: self.homeLoanArray[indexPath.row].id)
//        self.indexSelection = indexPath.row
//              collectionView.reloadData()


    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let selectedCell = collctionView.cellForItem(at: indexPath) as? HomeVCCollectionViewCell
////               selectedCell.viewBG.backgroundColor =
//        selectedCell?.loanTypeLabel.textColor = UIColor(red: 108/155, green: 111/255, blue: 143/255, alpha: 1)
////           self.homeLoanData(loanID: self.homeLoanArray[indexPath.row].id)
//    }
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeLoanData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aTableView.dequeueReusableCell(withIdentifier: "HomeTableCollectionViewCell", for: indexPath) as! HomeTableCollectionViewCell
        cell.configureCell(response: homeLoanData[indexPath.row])
//        cell.calculateEMIOtlt.setTitle("Calculate EMI".localized(lang), for: .normal)
        let view = UIView()
        view.backgroundColor = .clear
        cell.selectedBackgroundView = view
            
//        cell.calulateEMI = {[weak self]  in
//                       if let strongSelf = self {
//                        strongSelf.openViewController(controller: CalculateEMIViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
//                            vc.getLoanData = self?.homeLoanData[indexPath.row]
//                        })
//
//                       }
//
//
//        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openViewController(controller: BankDetailViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
            vc.bankDetail = self.homeLoanData[indexPath.row]
            vc.id = self.homeLoanData[indexPath.row].id
    })
    }
    func myUserData(){
        let params =  [String : Any]()
     
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForMyUserData(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let userDatas = parseData["data"]
             
                let user = User(fromJson:userDatas)
                AppHelper.setStringForKey(user.name, key: ServiceKeys.full_name)
                AppHelper.setStringForKey(user.image, key: ServiceKeys.profile_image)
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
    func homeLoanTypeAPI(){
        let params =  [String : Any]()
       
       
//        AppManager.init().hudShow()
//        Common.startActivityIndicator(baseView: collctionView)
//        ServiceClass.sharedInstance.hitServiceForHomeLoan(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
//            print_debug("response: \(parseData)")
//            Common.stopActivityIndicator(baseView: self.collctionView)
//            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
//                let getData = parseData["data"]
//                self.homeLoanArray.removeAll()
//                for obj in getData["loan_types"].arrayValue {
//                   let comObj = LoanType(fromJson:obj)
//                    self.homeLoanArray.append(comObj)
//                }
//                }
//
//             else {
//
//                guard let dicErr = errorDict?["msg"] as? String else {
//                    return
//                }
//                Common.showAlert(alertMessage: (dicErr), alertButtons: ["Ok"]) { (bt) in
//                }
//
//
//            }
//
//        })
    }
    func homeLoanData(loanID:String){

        let params =  [String : Any]()
     
        Common.startActivityIndicator(baseView: aTableView)
        ServiceClass.sharedInstance.hitServiceForHomeLoanData(params, loanType: loanID, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            Common.stopActivityIndicator(baseView: self.aTableView)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
//                let loanType = parseData["loan_types"].stringValue
                self.homeLoanData.removeAll()
                for obj in getData["lenders"].arrayValue {
                   let comObj = LoanList(fromJson:obj)
                    self.homeLoanData.append(comObj)
                }
                if self.homeLoanData.count  < 1 {
                    self.showErrorOnView(message: "No data Found", imag: UIImage(), retry_BtnShow: false)
                }
//                let myIndexPath = IndexPath(row: 0, section: 0)
//                let selectedCell = self.collctionView.cellForItem(at: myIndexPath) as? HomeVCCollectionViewCell
//                selectedCell?.isSelected = true
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

