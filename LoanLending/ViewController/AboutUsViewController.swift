//
//  AboutUsViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import WebKit
class AboutUsViewController: UIViewController,UIWebViewDelegate,WKNavigationDelegate {

   
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var webivew: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
        webivew.navigationDelegate = self
    }
    
    private func openWebView() {
      
        let setaboutUS = "\(ServiceUrls.abousUS)\(lang)"
        let url = URL(string: ServiceUrls.webBaseurl + setaboutUS )
      
        if let urlLink = url {
            let request = URLRequest(url: urlLink)
            webivew.load(request)
            
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //Show loader
        AppManager.init().hudShow()
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Hide loader
        AppManager.init().hudHide()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //Hide loader
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
