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
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var aWebView: WKWebView!
    override func viewDidLoad() {
            super.viewDidLoad()
            openWebView()
        }
        
        private func openWebView() {
            if lang == "en" {
            let url = URL(string:"http://192.168.1.134:9020/mobile/terms_of_use/en")
            if let urlLink = url {
                let request = URLRequest(url: urlLink)
                aWebView.load(request)
            }
            }
            else {
                let url = URL(string:"http://192.168.1.134:9020/mobile/terms_of_use/fr")
                if let urlLink = url {
                    let request = URLRequest(url: urlLink)
                    aWebView.load(request)
                }
            }
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
         
            
//            self.navigationController?.isNavigationBarHidden = true
        }
    
       
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    }
