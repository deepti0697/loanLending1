//
//  HistoryVC.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var aTableView: UITableView!
    var sectionArray = ["09-09-2020","09-09-2020"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
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
       
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return sectionArray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           return 10
                
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
     
            
                return  140
            }
            
       
        
    
}
