//
//  SideMenuViewController.swift
//  FORSA
//
//  Created by apple on 17/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class SideMenuViewController: BaseViewController {
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var lblVerified: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var tblMenu: UITableView!
    
    let menuArr = [("My Loans","user"),("Loan History","loanHistorymenu"),("Notifications","notificationsmenu"),("More","moremenu"),("Logout","logoutmenu")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblMenu.delegate = self
        tblMenu.dataSource = self
    }
    
    @IBAction func btnProfileAction(_ sender: Any) {
    }
    
   
    @IBAction func sideMenuClose(_ sender: Any) {
//        / self.dismiss(animated: true, completion: nil)
        panel?.closeLeft() 
    }
    

}
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.lblName.text = menuArr[indexPath.row].0.localized(lang)
        cell.imgKey.image = UIImage(named: menuArr[indexPath.row].1)
        if indexPath.row == 3 {
            cell.arrowImageView?.isHidden = false
        }
        else {
            cell.arrowImageView?.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
//            let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
//            let vc1 = storyBoard.instantiateViewController(withIdentifier: "LoanVC") as! LoanVC
//            let nv4 = UINavigationController(rootViewController: vc1)
            panel?.closeLeft()
//            self.tabBarController?.selectedIndex = 1
////            self.navigationController?.pushViewController(nv4, animated: true)
//            openViewController(controller: LoanVC.self, storyBoard: .mainStoryBoard, handler: { (vc) in
//        })
            appdelegate.tabBarController.selectedIndex  = 1
        
        }
        else if indexPath.row == 1 {
            panel?.closeLeft()

            appdelegate.tabBarController.selectedIndex  = 2
        }
        else if indexPath.row == 2 {
//            panel?.closeLeft()
//            self.tabBarController?.selectedIndex = 2
        }
        else if indexPath.row == 3 {
              panel?.closeLeft()
            print(appdelegate.tabBarController.selectedIndex)
            appdelegate.setupMore()
//            appdelegate.isComingFromSideMenu = true
////            appdelegate.tabBarController.selectedIndex = appdelegate.tabBarController.selectedIndex
//            openViewController(controller: MoreViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
//                    })
//        }
        }
    }
}
