//
//  AppDelegate.swift
//  LoanLending
//
//  Created by Subhash on 12/01/21.
//

import UIKit
import IQKeyboardManagerSwift
import FAPanels
import Firebase
import FirebaseCrashlytics
import FirebaseMessaging
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"
    var islogout = false 
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
        FirebaseApp.configure()
        Crashlytics.crashlytics()
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
//                appdelegate.setHomeView()
                setHomeView(selectedIndex: 0)
            }
            else {
                self.initalViewController()
            }
        }
       
//
        return true
    }

    func initalViewController(){
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let nv4 = UINavigationController(rootViewController: vc1)
      
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    func aboutUSViewController(){
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        let nv4 = UINavigationController(rootViewController: vc1)
      
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    func privacyViewController(){
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        let nv4 = UINavigationController(rootViewController: vc1)
      
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    func termsAndConditionViewController(){
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "TermAndConditionViewController") as! TermAndConditionViewController
        let nv4 = UINavigationController(rootViewController: vc1)
        vc1.isBackNavigtn = false
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    
    func setHomeView(selectedIndex:Int) {
        
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
        
        
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        let nv4 = UINavigationController(rootViewController: vc4)
        //   nv4.restorationIdentifier = "chatsListViewController"
        
        // nv5.restorationIdentifier = "logoutViewController"
        
        nv1.tabBarItem = UITabBarItem.init(title: "first", image: UIImage(named: "Homeunselect")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal))
        nv1.tabBarItem.imageInsets = UIEdgeInsets(top: 05, left: 0, bottom: 0, right: 0)
        nv2.tabBarItem = UITabBarItem.init(title: "secnds", image: UIImage(named: "myLoanunselect")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "myLoan")?.withRenderingMode(.alwaysOriginal))
        nv2.tabBarItem.imageInsets = UIEdgeInsets(top: 05, left: 0, bottom: 0, right: 0)
        nv3.tabBarItem = UITabBarItem.init(title: "third", image: UIImage(named: "Historyunselect")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "History")?.withRenderingMode(.alwaysOriginal))
        nv3.tabBarItem.imageInsets = UIEdgeInsets(top: 05, left: 0, bottom: 0, right: 0)
        nv4.tabBarItem = UITabBarItem.init(title: "fourth", image: UIImage(named: "Accountunselect")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Account")?.withRenderingMode(.alwaysOriginal))
        nv4.tabBarItem.imageInsets = UIEdgeInsets(top: 05, left: 0, bottom: 0, right: 0)
        
       // nv3.tabBarItem.isEnabled = false
        let lang = AppHelper.getStringForKey(ServiceKeys.languageType)
        nv1.tabBarItem.title = "home".localized(lang)
        nv2.tabBarItem.title = "myLoans".localized(lang)
        nv3.tabBarItem.title = "history".localized(lang)
        nv4.tabBarItem.title = "account".localized(lang)
     
        
        
        // Fallback on earlier versions
//        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
//        tabBarController.tabBar.layer.shadowRadius = 5
//        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
//        tabBarController.tabBar.layer.shadowOpacity = 1
        
//        tabBarController.tabBar.shadowImage = nil
       
        tabBarController.viewControllers = [nv1, nv2, nv3, nv4]
        tabBarController.tabBar.tintColor = UIColor(red: 38/255, green: 149/255, blue: 190/255, alpha: 1)
        tabBarController.selectedIndex = selectedIndex
        
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
        UITabBar.appearance().tintColor = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 38/255, green: 149/255, blue: 190/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        
    }
    func setupMore(){
        let storyBoard  = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        let nv4 = UINavigationController(rootViewController: vc1)
      
        self.window?.rootViewController = nv4
        self.window?.makeKeyAndVisible()
    }
    func applogout() {
        if islogout {
            displayAlert()
        }
    }
    func displayAlert() {
        AppManager().showAlertMulti(withHandler: "Sign Out", message: "Are you sure you want to Sign Out?", buttonTitle1: "Cancel", buttonTitle2: "Yes") {
//                Constants.kUserDefaults.set(0, forKey: "SessionOut")
//                UserDefaults.standard.removeObject(forKey: "user")
//                Constants.kAppDelegate.user = nil
//                self.switchLoginVC()
            self.logoutAction()
        }
//
    }
    func logoutAction() {
        
               
        UserDefaults.standard.removeObject(forKey: ServiceKeys.user_id)
        UserDefaults.standard.removeObject(forKey: ServiceKeys.token)
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
extension AppDelegate:UNUserNotificationCenterDelegate,MessagingDelegate {
    //MARK: - Register User Notifications
    
    func registerForRemoteNotification() {
        
        if #available(iOS 10.0, *)
        {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted)
                {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    
                }
                else{
                    AppDelegate.print("Notifications permission not given")
                }
            })
        }
        else
        {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    // MARK: - Remote Notification Methods // <= iOS 9.x
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        NSLog("didFailToRegisterForRemoteNotificationsWithError Error = %@", error.localizedDescription)
    }
    
    // MARK: - UNUserNotificationCenter Delegate // >= iOS 10
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID--->: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
        
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            AppDelegate.print("Message ID: \(messageID)")
        }
        
        // Print full message.
        AppDelegate.print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func GetFCMToken()
    {
        
        Messaging.messaging().token { token, error in
            if let error = error {
                AppDelegate.print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                AppDelegate.print("FCM registration token: \(token)")
//                kAppDeviceId = "\(token)"
//                defaults[.DeviceToken] = kAppDeviceId
                AppHelper.setStringForKey("\(token)", key: ServiceKeys.device_token)
            }
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        AppDelegate.print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    public static func print(_ items: Any..., separator: String = " ", terminator: String = "\n", _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        //#if targetEnvironment(simulator)
        let stringItem = items.map {"\($0)"} .joined(separator: separator)
        Swift.print("\(stringItem)", terminator: terminator)
        //#endif
    }
}
