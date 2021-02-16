//
//  AboutUsViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import WebKit
class AboutUsViewController: UIViewController {

   
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var webivew: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
    }
    
    private func openWebView() {
        let setaboutUS = "\(ServiceUrls.abousUS)\(lang)"
        let url = URL(string: ServiceUrls.webBaseurl + setaboutUS )
      
        if let urlLink = url {
            let request = URLRequest(url: urlLink)
            webivew.load(request)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func backButtonAction(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        appdelegate.setHomeView(selectedIndex: appdelegate.tabBarController.selectedIndex)
    }
    
}
