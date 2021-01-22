//
//  AppDelegate.swift
//  LoanLending
//
//  Created by Subhash on 12/01/21.
//

import UIKit
import IQKeyboardManagerSwift
import FAPanels
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
//    var kWindow = UIWindow(frame: UIScreen.main.bounds)
//     let appdelegate = UIApplication.shared.delegate as! AppDelegate
//    var kScreenSize         = UIScreen.main.bounds.size

    var window: UIWindow?
    var currentNavController:UINavigationController?
  var tabBarController = UITabBarController()
    var isComingFromSideMenu = false
  var navigationController:UINavigationController?
  let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
  var selectedVC : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
         Thread.sleep(forTimeInterval: 3.0)
         IQKeyboardManager.shared.enable = true
        if (AppHelper.getStringForKey(ServiceKeys.languageType) == "") {
            let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "ChooseLanguageVc") as! ChooseLanguageVc
            let nv4 = UINavigationController(rootViewController: vc1)
          
            self.window?.rootViewController = nv4
            self.window?.makeKeyAndVisible()
        }
        else {
            if  (AppHelper.getStringForKey(ServiceKeys.token) != "") {
                let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
                let vc1 = storyBoard.instantiateViewController(withIdentifier: "ToucIDAndTouchFaceVC") as! ToucIDAndTouchFaceVC
                let nv4 = UINavigationController(rootViewController: vc1)
              
                self.window?.rootViewController = nv4
                self.window?.makeKeyAndVisible()
//                setHomeView()
            }
            else {
                let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
                let vc1 = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let nv4 = UINavigationController(rootViewController: vc1)
              
                self.window?.rootViewController = nv4
                self.window?.makeKeyAndVisible()
            }
        }
       
//
        return true
    }

    func setHomeView() {
        
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let nv1 = UINavigationController(rootViewController: vc1)
        // nv1.restorationIdentifier = "gigListViewController"
         self.selectedVC = nv1
        var nv2 : UINavigationController!
        
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "LoanVC") as! LoanVC
        nv2 = UINavigationController(rootViewController: vc2)
        //  nv2.restorationIdentifier = "gigsListViewController"
        
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
        let nv3 = UINavigationController(rootViewController: vc3)
        
        //  nv3.restorationIdentifier = "communityViewController"
        
        
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        let nv4 = UINavigationController(rootViewController: vc4)
        //   nv4.restorationIdentifier = "chatsListViewController"
        
        
       
      
        // nv5.restorationIdentifier = "logoutViewController"
        
        nv1.tabBarItem = UITabBarItem.init(title: "first", image: UIImage(named: "Homeunselect"), selectedImage: UIImage(named: "Home"))
        nv2.tabBarItem = UITabBarItem.init(title: "secnds", image: UIImage(named: "myLoanunselect"), selectedImage: UIImage(named: "myLoan"))
        nv3.tabBarItem = UITabBarItem.init(title: "third", image: UIImage(named: "Historyunselect"), selectedImage: UIImage(named: "History"))
        nv4.tabBarItem = UITabBarItem.init(title: "fourth", image: UIImage(named: "Account"), selectedImage: UIImage(named: "Accountunselect"))
        
       // nv3.tabBarItem.isEnabled = false
        let lang = AppHelper.getStringForKey(ServiceKeys.languageType)
        nv1.tabBarItem.title = "home".localized(lang)
        nv2.tabBarItem.title = "myLoans".localized(lang)
        nv3.tabBarItem.title = "history".localized(lang)
        nv4.tabBarItem.title = "account".localized(lang)
     
        
        
        // Fallback on earlier versions
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarController.tabBar.layer.shadowRadius = 5
        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController.tabBar.layer.shadowOpacity = 0.5
        
        tabBarController.tabBar.shadowImage = nil
       
        tabBarController.viewControllers = [nv1, nv2, nv3, nv4]
        tabBarController.tabBar.tintColor = UIColor(red: 38/255, green: 149/255, blue: 190/255, alpha: 1)
        tabBarController.selectedIndex = 0
        
        customizeTabBarView()
        if self.navigationController == nil {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let leftMenuVC = storyboard.instantiateViewController(withIdentifier: "sideMenuViewController") as! SideMenuViewController

            let rootController = FAPanelController()
            rootController.configs.bounceOnRightPanelOpen = false
            rootController.configs.canLeftSwipe = false
            rootController.configs.canRightSwipe = false

            rootController.rightPanelPosition = .back
            rootController.configs.maxAnimDuration = 0.30
            rootController.configs.leftPanelWidth = UIScreen.main.bounds.width * 1
            _ = rootController.center(self.tabBarController).left(leftMenuVC)
            self.window?.rootViewController = rootController
            self.window?.makeKeyAndVisible()
        }else {
            self.navigationController?.present(tabBarController, animated: true, completion: {
                
            })
        }
        
         
      
      

  


}
    fileprivate func customizeTabBarView() {
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 38/255, green: 149/255, blue: 190/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .normal)
    }
    func setupMore(){
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        let nv4 = UINavigationController(rootViewController: vc1)
      
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
}
