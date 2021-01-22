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

    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var allLoansLabel: UILabel!
    @IBOutlet weak var allLendersLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var collctionView: UICollectionView!
    var LblArray = ["Personal Loan","Auto Loan","Mortgage Loan","Others"]
    var imageArray = [#imageLiteral(resourceName: "mortgageLoan@1"),#imageLiteral(resourceName: "AutoLoan"),#imageLiteral(resourceName: "mortgageLoan@1"),#imageLiteral(resourceName: "Others@1")]
    var homeLoanArray = [LoanType](){
        didSet {
            
            self.collctionView.reloadData()
            if homeLoanArray.count > 0 {
                
                    self.homeLoanData(loanID: self.homeLoanArray[0].id)
                }
            }
        
    }
    var homeLoanData = [LoanList](){
        didSet {
            self.aTableView.reloadData()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collctionView.delegate = self
        collctionView.dataSource = self
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: self.view.frame.width/4, height: self.view.frame.width/4)
              collectionLayout.minimumInteritemSpacing = 1 
        collectionLayout.scrollDirection = .horizontal
        collctionView.collectionViewLayout = collectionLayout
        homeLoanTypeAPI()
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
//        UITabBar.appearance().barTintColor = UIColor.black
        
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
        return homeLoanArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVCCollectionViewCell", for: indexPath) as! HomeVCCollectionViewCell
        cell.configureCell(response: homeLoanArray[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeLoanData(loanID: self.homeLoanArray[indexPath.row].id)
    }
    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeLoanData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aTableView.dequeueReusableCell(withIdentifier: "HomeTableCollectionViewCell", for: indexPath) as! HomeTableCollectionViewCell
        cell.configureCell(response: homeLoanData[indexPath.row])
        cell.calculateEMIOtlt.setTitle("Calculate EMI".localized(lang), for: .normal)
        let view = UIView()
        view.backgroundColor = .clear
            cell.selectedBackgroundView = view
            
        cell.calulateEMI = {[weak self]  in
                       if let strongSelf = self {
                        strongSelf.openViewController(controller: CalculateEMIViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                        })
                        
                       }
            
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openViewController(controller: BankDetailViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
    })
    }
    func homeLoanTypeAPI(){
        let params =  [String : Any]()
       
       
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForHomeLoan(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
//                let loanType = parseData["loan_types"].stringValue
                for obj in getData["loan_types"].arrayValue {
                   let comObj = LoanType(fromJson:obj)
                    self.homeLoanArray.append(comObj)
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
    func homeLoanData(loanID:String){
        let params =  [String : Any]()
     
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForHomeLoanData(params, loanType: loanID, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
//                let loanType = parseData["loan_types"].stringValue
                self.homeLoanData.removeAll()
                for obj in getData["lenders"].arrayValue {
                   let comObj = LoanList(fromJson:obj)
                    self.homeLoanData.append(comObj)
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

