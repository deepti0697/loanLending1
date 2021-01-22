//
//  LoginViewController.swift
//  LoanLending
//
//  Created by deepti on 12/01/21.
//

import UIKit
import Foundation
import SwiftyJSON
class LoginViewController: UIViewController {
    
    @IBOutlet weak var remeberMeImageView: UIImageView!
    @IBOutlet weak var remeberMeLbl: UILabel!
    @IBOutlet weak var logibLbl: UILabel!
    @IBOutlet weak var loginBtm: UIButton!
    @IBOutlet weak var sign_UpNowBtn: UIButton!
    @IBOutlet weak var dontHave_Lbl: UILabel!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_Mobile: UITextField!
    @IBOutlet weak var btn_ShowPassword: UIButton!
    @IBOutlet weak var password_Lbl: UILabel!
    @IBOutlet weak var mobile_Lbl: UILabel!
    @IBOutlet weak var forgot_PasswordBtn: UIButton!
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_Mobile.delegate = self
        self.txt_Password.delegate = self
        localizedString()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    /// UISetup
    func setup(){
        self.txt_Mobile.setLeftPaddingPoints(5.0)
        self.txt_Password.setLeftPaddingPoints(5.0)
        let color = UIColor.white
        let placeholder = txt_Mobile.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        txt_Mobile.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        let placeHolder2 = txt_Password.placeholder ?? ""
        txt_Password.attributedPlaceholder = NSAttributedString(string: placeHolder2, attributes: [NSAttributedString.Key.foregroundColor : color])
//        self.txt_Password.layer.borderWidth = 1.0
//        self.txt_Mobile.layer.borderWidth = 1.0
        self.txt_Password.layer.borderColor = UIColor.white.cgColor
        self.txt_Mobile.layer.borderColor = UIColor.white.cgColor
        self.txt_Password.RightViewImage(UIImage.init(named: "password-view-1"))
//        self.btnRememberMe.setTitle("remember".localized(lang), for: .normal)
    }
    
    
    /// String Localized
    func localizedString(){
//        elf.signUpBtnOtlt.setTitle("sign up".localized(lang), for: .normal)
        self.mobile_Lbl.text =  ("mobileNo".localized(lang))
        self.txt_Mobile.placeholder = ("enterNumber".localized(lang))
        self.forgot_PasswordBtn.setTitle("forgotPassword", for: .normal)
        self.txt_Password.placeholder = ("password".localized(lang))
        self.dontHave_Lbl.text = ("dont_have_an_Account".localized(lang))
        self.sign_UpNowBtn.setTitle("signup".localized(lang), for: .normal)
        forgot_PasswordBtn.setTitle("forgotPassword".localized(lang), for: .normal)
        self.loginBtm.setTitle("login".localized(lang), for: .normal)
        self.logibLbl.text = ("login".localized(lang))
        
    }
    
    @IBAction func remeberMeAction(_ sender: UIButton) {
        if sender.isSelected {
            self.remeberMeImageView.image = #imageLiteral(resourceName: "uncheck")
        }
        else {
            self.remeberMeImageView.image = #imageLiteral(resourceName: "check")
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btn_ShowPasswordAction(_ sender: UIButton) {
        if btn_ShowPassword.tag == 1 {
            txt_Password.isSecureTextEntry = false
            self.txt_Password.RightViewImage(UIImage.init(named: "password_icon-1"))
            btn_ShowPassword.tag = 2
        }
        else {
            self.txt_Password.RightViewImage(UIImage.init(named: "password-view-1"))
            txt_Password.isSecureTextEntry = true
            
            btn_ShowPassword.tag = 1
            
        }
    }
    
    @IBAction func btn_LoginPasswordAction(_ sender: UIButton) {
            
        if  (txt_Mobile.text?.count)! >= 10 {
//
                if (txt_Password.text?.count)! > 5 {
                    login()
                    
                }
        

                 else {
                    AppManager.init().showAlertSingle(kAppName, message:"correctPassword".localized(lang), buttonTitle: "Ok") {

                                }

                }
            } else {
                AppManager.init().showAlertSingle(kAppName, message:"Valid_NUMBER".localized(lang), buttonTitle: "Ok") {

                            }
               
               
            }
//        self.view.endEditing(true)
    }

    @IBAction func signupAction(_ sender: Any) {
        openViewController(controller: SignUPFirstVC.self, storyBoard: .mainStoryBoard, handler: { (vc) in
    })
    }
    @IBAction func onRememberMeClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    func login(){
        var params =  [String : Any]()
       
        params["mobile"]  = self.txt_Mobile.text ?? ""
        params["password"] = self.txt_Password.text ?? ""
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForlogin(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let getData = parseData["data"]
                let token = getData["token"].stringValue
                AppHelper.setStringForKey(token, key: ServiceKeys.token)
                let userData = getData["user"]
                let user = User(fromJson:userData)
                print(user)
              
               AppHelper.setStringForKey(user.email, key: ServiceKeys.email)
              
                AppHelper.setStringForKey(user.id, key: ServiceKeys.user_id)
                appdelegate.setHomeView()
                }
             else {
                
                guard let dicErr = errorDict?["msg"] as? String else {
                    return
                }
                Common.showAlert(alertMessage: (dicErr), alertButtons: ["Ok"]) { (bt) in
                }
                
                
            }
        })
    }

}
extension LoginViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_Mobile {
           textField.resignFirstResponder()
            txt_Password.becomeFirstResponder()
        } else if textField == txt_Password {
           textField.resignFirstResponder()
//           txtFieldPassword.becomeFirstResponder()
        }
       return true
      }
    
}
