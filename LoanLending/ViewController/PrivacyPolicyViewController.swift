//
//  PrivacyPolicyViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import WebKit
class PrivacyPolicyViewController: UIViewController {
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var aWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
    }
    
    private func openWebView() {
        let setPrivacyURL = "\(ServiceUrls.privac_policy)\(lang)"
        let url = URL(string: ServiceUrls.webBaseurl + setPrivacyURL )
        if let urlLink = url {
            let request = URLRequest(url: urlLink)
            aWebView.load(request)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: "Privacy Policy", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        appdelegate.setHomeView(selectedIndex: appdelegate.tabBarController.selectedIndex)
    }
    
}
