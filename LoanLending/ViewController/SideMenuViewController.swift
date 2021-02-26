//
//  SideMenuViewController.swift
//  FORSA
//
//  Created by apple on 17/09/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SDWebImage
class SideMenuViewController: BaseViewController {
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var lblVerified: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var tblMenu: UITableView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    let menuArr = [("My Loans","user"),("Loan History","loanHistorymenu"),("About Us","abouticon"),("Contact us","mail"),("FAQ's", "faq"),("T & C", "ordersmenu"),("Privacy policy","privacypolicy"),("Logout","logoutmenu")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblMenu.delegate = self
        tblMenu.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.userNameLbl.text = AppHelper.getStringForKey(ServiceKeys.full_name)
     
            let urlString = AppHelper.getStringForKey(ServiceKeys.profile_image).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
        imgUser?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "icons8Men"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        
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
//        if indexPath.row == 3 {
//            cell.arrowImageView?.isHidden = false
//        }
//        else {
            cell.arrowImageView?.isHidden = true
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

            panel?.closeLeft()
//            appdelegate.tabBarController.selectedIndex  = 1
            appdelegate.setHomeView(selectedIndex: 1)
        
        }
        else if indexPath.row == 1 {
            panel?.closeLeft()

            appdelegate.setHomeView(selectedIndex: 2)
        }
        else if indexPath.row == 2 {
            panel?.closeLeft()                              
            appdelegate.aboutUSViewController()
        }
        else if indexPath.row == 3 {
            panel?.closeLeft()
            appdelegate.contactUsViewController()

        }
        else if indexPath.row == 4{
            panel?.closeLeft()
            appdelegate.fAQViewController()

        }
        else  if indexPath.row == 5
        {
            panel?.closeLeft()
            appdelegate.termsAndConditionViewController()
        }
        else  if indexPath.row == 6
        {
            panel?.closeLeft()
            appdelegate.privacyViewController()
        }
        else  if indexPath.row == 7 {
//            displayAlert()
           
            appDelegate.islogout = true
            panel?.closeLeft()
            appdelegate.applogout()
            
          
        }
    }
    func displayAlert() {
       
        let alert = UIAlertController(title: kAppName, message: "Are you sure you want to log out", preferredStyle: UIAlertController.Style.alert)
        alert.addAction((UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })))
        alert.addAction((UIAlertAction(title: "Proceed", style: .default, handler: { (action) -> Void in
            self.logoutAction()
        })))
        
        
    }
    func logoutAction() {
        
               
        UserDefaults.standard.removeObject(forKey: ServiceKeys.user_id)
        UserDefaults.standard.removeObject(forKey: ServiceKeys.token)
//        panel?.closeLeft()
        appdelegate.initalViewController()
//        UserDefaults.standard.removeObject(forKey: ServiceKeys.)
//                       UserDefaults.standard.removeObject(forKey: kMobileNumber)
//                       UserDefaults.standard.removeObject(forKey: kReferCode)
//                       UserDefaults.standard.removeObject(forKey: kTeamName)
//                       UserDefaults.standard.removeObject(forKey: kPanCardNo)
//                       UserDefaults.standard.removeObject(forKey: kBankAccountNo)
//                       UserDefaults.standard.removeObject(forKey: kInviteReferCode)
//                       UserDefaults.standard.set(false, forKey: kLoggedIn)
                  
                                                                 
                                                                 
                                                                 // Get Login User Data
//
//                               if let googleSignIn = GIDSignIn.sharedInstance() {
//                           googleSignIn.signOut()
//                       }
//                       LoginManager().logOut()
//                       APP_DEL.openInitialViewController()
          
       
       
    }
}
