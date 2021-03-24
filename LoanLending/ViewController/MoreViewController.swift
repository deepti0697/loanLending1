//
//  MoreViewController.swift
//  FantasyCricket
//
//  Created by Developer on 15/05/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit


class MoreViewController: UIViewController {
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    
    @IBOutlet weak private var aTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.delegate = self
        aTableView.tableFooterView = UIView()
        registerCell()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
//        appdelegate.setHomeView()
        panel?.openLeft(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        registerCell()
//        addNavigationBar(navigationTitle: "More", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: false, isWalletButtonShow: false, isBinButtonShow: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func registerCell() {
        aTableView.register(UINib(nibName: "MoreTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTableViewCell")

    }
    
    func openProfile() {
        openViewController(controller: ProfileOneVC.self, storyBoard: .mainStoryBoard) { (vc) in
      
              }
        
    }
    
    func openChangePassword() {
        
        openViewController(controller: ChangePasswordViewController.self, storyBoard: .mainStoryBoard) { (vc) in
      //            vc.isFromMore = true
              }
    }
    
    func openVerifyAccount() {
        
    }
    
    func openFantasyPointSystem() {
      
    }
    
    func openMyWallet() {
//        openViewController(controller: AccountViewController.self, storyBoard: .accountStoryBoard) { (vc) in
//            vc.isFromMore = true
//        }
    }
    
    func openReferList() {
        
    }
    
    func openLeaderBoard() {
//        openViewController(controller: LeaderBoardViewController.self, storyBoard: .moreStoryBoard) { (vc) in
//
//        }
    }
    
    func openPrivacyPolicy() {
        openViewController(controller: PrivacyPolicyViewController.self, storyBoard: .mainStoryBoard) { (vc) in
                }
    }
    func openFAQ() {
        openViewController(controller: FQsViewController.self, storyBoard: .mainStoryBoard) { (vc) in
                }
    }
    
    func openTermAndCondition() {
        openViewController(controller: TermAndConditionViewController.self, storyBoard: .mainStoryBoard) { (vc) in
            vc.isBackNavigtn = false
                }
    }
    
    func openAboutUs() {
        openViewController(controller: AboutUsViewController.self, storyBoard: .mainStoryBoard) { (vc) in
                }
    }
    
   
    
    func openContactUs() {
        openViewController(controller: ContactUsViewController.self, storyBoard: .mainStoryBoard) { (vc) in
                }
    }
    
   
    
    func openFqs() {
        openViewController(controller: FQsViewController.self, storyBoard: .mainStoryBoard) { (vc) in
                }
    }
    
   
    
   
  
    func footerMethod() {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: aTableView.frame.size.width, height: 1)
        footerView.backgroundColor = aTableView.separatorColor
        aTableView.tableFooterView = footerView
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreTitlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
           
        cell.configCell(imageName: moreImagesArray[indexPath.row], title: moreTitlesArray[indexPath.row].localized(lang), showTitle: false)
            
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
         openProfile()
        case 1:
            openChangePassword()
        case 2:
            openAboutUs()
        case 3:
            openContactUs()
//            contact
        case 4:
      openFqs()
          
        case 5:
                openTermAndCondition()
        break
        // Personel Info
        case 6:
            openPrivacyPolicy()
        break
        case 7:
            displayAlert()
       
             
        default:
            break
        }
    }
    func displayAlert() {
       
        let alert = UIAlertController(title: kAppName, message: "Are you sure you want to Sign out", preferredStyle: UIAlertController.Style.alert)
        alert.addAction((UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })))
        alert.addAction((UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.logoutAction()
        })))
        self.present(alert, animated: true, completion: nil)
        
    }
    func logoutAction() {
                       
        UserDefaults.standard.removeObject(forKey: ServiceKeys.user_id)
        UserDefaults.standard.removeObject(forKey: ServiceKeys.token)
//        panel?.closeLeft()
        appdelegate.initalViewController()
    }
}
