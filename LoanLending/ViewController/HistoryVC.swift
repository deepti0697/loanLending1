//
//  HistoryVC.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit
import SwiftyJSON
class HistoryVC: UIViewController {

    @IBOutlet weak var aTableView: UITableView!
    var sectionArray = ["09-09-2020","09-09-2020"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    var getLoanHistory = [LoanHistory](){
        didSet {
            aTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        myHistoryData()
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
extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell
        let view = UIView()
        view.backgroundColor = .clear
        cell.selectedBackgroundView = view
        cell.bankNameLbl.text = stringToDate(date: getLoanHistory[indexPath.row].updated_at)
        if getLoanHistory[indexPath.row].status == "PAID"{
            cell.loanAmountRcvdLbl.text = "Amount Received by \(getLoanHistory[indexPath.row].lender?.name ?? "")"
            cell.amountLbl.text = "$ \(getLoanHistory[indexPath.row].amount ?? "")"
            cell.amountLbl.textColor = UIColor(red: 49/255, green: 185/255, blue: 139/255, alpha: 1)
            cell.imageCheck.image = #imageLiteral(resourceName: "Complete@1")
            
        }
        else if getLoanHistory[indexPath.row].status == "DECLINE"{
            cell.loanAmountRcvdLbl.text = "Loan Decline by \(getLoanHistory[indexPath.row].lender?.name ?? "")"
            cell.amountLbl.text = "₵ \(getLoanHistory[indexPath.row].amount ?? "")"
            cell.amountLbl.textColor = UIColor(red: 185/255, green: 34/255, blue: 34/255, alpha: 1)
            cell.imageCheck.image = #imageLiteral(resourceName: "Incomplete@1")
        }
        else {
            cell.loanAmountRcvdLbl.text = "Completed"
            cell.amountLbl.text = "₵ \(getLoanHistory[indexPath.row].amount ?? "")"
            cell.amountLbl.textColor = .black
            cell.imageCheck.image = #imageLiteral(resourceName: "completeDisebal@1")
        }
        return cell
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        return sectionArray.count
//
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getLoanHistory.count
                
        }
        
    
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//            // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
//        let headerView = UIView ()
//            guard let customView = Bundle.main.loadNibNamed("ContestCategoryTableHeaderView", owner: self, options: nil)?.first as? ContestCategoryTableHeaderView else  {
//                return headerView
//            }
//            customView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 70)
//            headerView.addSubview(customView)
//            customView.configureCell2(category: sectionArray[section])
//            return headerView
//
//
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//
//            return 50
//
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
            
                return  100
            }
            
       
        
    
}
extension HistoryVC {
    func myHistoryData(){
        let params =  [String : Any]()
     
        Common.startActivityIndicator(baseView: aTableView)
        ServiceClass.sharedInstance.hitServiceFoHisstoryData(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            Common.stopActivityIndicator(baseView: self.aTableView)
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
             //                let loanType = parseData["loan_types"].stringValue
                self.getLoanHistory.removeAll()
                for obj in parseData["data"].arrayValue {
                   let comObj = LoanHistory(fromJson:obj)
                    self.getLoanHistory.append(comObj)
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
    func stringToDate(date: String)->String  {
        let formatter = DateFormatter()

        let splitedDate = date.components(separatedBy: "T")
        if splitedDate.count > 0 {
            formatter.dateFormat = "yyyy/MM/dd"
//            if let parsedDate = formatter.date(from: splitedDate[0]) {
                return "Date: \(splitedDate[0])"
//            }
        }
        // Format 1
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        if let parsedDate = formatter.date(from: date) {
//            return parsedDate
//        }
//
//        // Format 2
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
//        if let parsedDate = formatter.date(from: date) {
//            return parsedDate
//        }

        // Couldn't parsed with any format. Just get the date
      

        // Nothing worked!
       return String()
    }
}






