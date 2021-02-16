//
//  TermAndConditionViewController.swift
//  DreamTeam
//
//  Created by Test on 13/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import WebKit
class TermAndConditionViewController: UIViewController {
    
    var isBackNavigtn = false
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var aWebView: WKWebView!
    override func viewDidLoad() {
            super.viewDidLoad()
            openWebView()
        }
        
        private func openWebView() {
            let setaboutUS = "\(ServiceUrls.abousUS)\(lang)"
            let url = URL(string: ServiceUrls.webBaseurl + setaboutUS )
                if let urlLink = url {
                    let request = URLRequest(url: urlLink)
                    aWebView.load(request)
                }
            }
            
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            
//            self.navigationController?.isNavigationBarHidden = true
        }
    
       
    @IBAction func backButton(_ sender: Any) {
        if isBackNavigtn {
            self.navigationController?.popViewController(animated: true)
        }
        else {
        appdelegate.setHomeView(selectedIndex: appdelegate.tabBarController.selectedIndex)
        }
    }
}
