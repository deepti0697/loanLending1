//
//  ViewController.swift
//  LoanLending
//
//  Created by Subhash on 12/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpBtnOtlt: UIButton!
    @IBOutlet weak var loginBtnOutlt: UIButton!
    @IBOutlet weak var logo: UIImageView!
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    override func viewDidLoad() {
        super.viewDidLoad()
        localizedString()
//        self.logo.contentMode = UIView.ContentMode.scaleAspectFill
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    /// MArk: String Localization
    func localizedString() {
        self.signUpBtnOtlt.setTitle("signup".localized(lang), for: .normal)
        self.loginBtnOutlt.setTitle("login".localized(lang), for: .normal)
    }
    @IBAction func loginAction(_ sender: UIButton) {
        switchLoginVC()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        openViewController(controller: SignUPFirstVC.self, storyBoard: .mainStoryBoard, handler: { (vc) in
    })
    }
    
// Mark: SwitchToLoginVC
    func switchLoginVC()  {
        openViewController(controller: LoginViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
    })
    }
}

