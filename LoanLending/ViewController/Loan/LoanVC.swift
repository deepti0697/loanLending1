//
//  LoanVC.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit

class LoanVC: UIViewController {

    @IBOutlet weak var aTableView: UITableView!
    var sectionArray = ["Paid Loans","Cancelled Loans","Declined Loans"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false) 
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
        if indexPath.section == 0 {
            cell.calculateEMI.isHidden = true
        }
        else if indexPath.section == 1 {
            cell.calculateEMI.isHidden = false
            cell.calculateEMI.setTitle("Cancel", for: .normal)
            cell.calculateEMI.backgroundColor = UIColor(red: 191/255, green: 147/255, blue: 75/255, alpha: 1)
            cell.calculateEMI.layer.borderColor = UIColor(red: 191/255, green: 147/255, blue: 75/255, alpha: 1).cgColor
            
        }
        else if indexPath.section == 2 {
            cell.calculateEMI.isHidden = false
            cell.calculateEMI.setTitle("Declined", for: .normal)
            cell.calculateEMI.backgroundColor = UIColor(red: 251/255, green: 49/255, blue: 59/255, alpha: 1)
            cell.calculateEMI.layer.borderColor = UIColor(red: 251/255, green: 49/255, blue: 59/255, alpha: 1).cgColor
            
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
            return 3
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           return 2
                
        }
        
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
            // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
        let headerView = UIView ()
            guard let customView = Bundle.main.loadNibNamed("ContestCategoryTableHeaderView", owner: self, options: nil)?.first as? ContestCategoryTableHeaderView else  {
                return headerView
            }
            customView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 70)
            headerView.addSubview(customView)
            customView.configureCell(category: sectionArray[section])
            return headerView
       
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
      
            return 50
      
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
            
                return  150
            }
            
       
        
    
}
