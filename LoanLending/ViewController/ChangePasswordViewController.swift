//
//  ChangePasswordViewController.swift
//  DreamTeam
//
//  Created by Test on 08/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var btn_ShowPassword: UIButton!
    @IBOutlet weak var btn_New_ShowPassword: UIButton!
    @IBOutlet weak var btn_Confirm_Show_Password: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
   
    @IBOutlet weak var confirmPassowrdTxtFld: UITextField!
    @IBOutlet weak var newPassowrdTxtFld: UITextField!
    @IBOutlet weak var oldPassowrdTextField: UITextField!
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var txt_Password: UITextField!
      var checkFromupdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.confirmPassowrdTxtFld.RightViewImage(#imageLiteral(resourceName: "icons8-hide-48"))
        self.newPassowrdTxtFld.RightViewImage(#imageLiteral(resourceName: "icons8-hide-48"))
        self.oldPassowrdTextField.RightViewImage(#imageLiteral(resourceName: "icons8-hide-48"))
        self.confirmPassowrdTxtFld.textColor = .black
        self.newPassowrdTxtFld.textColor = .black
        self.oldPassowrdTextField.textColor = .black
        self.oldPassowrdTextField.delegate = self
        self.newPassowrdTxtFld.delegate = self
        self.confirmPassowrdTxtFld.delegate = self
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    
    
    @IBAction func backtoForgotPasswordScreen(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func savePasswordBtn(_ sender: Any) {
        if  oldPassowrdTextField.text !=  "" {
//
                if newPassowrdTxtFld.text != "" {
                    
                    if (newPassowrdTxtFld.text?.count)! > 5 {
                    if confirmPassowrdTxtFld.text != newPassowrdTxtFld.text {
                        AppManager.init().showAlertSingle(kAppName, message:"Please match new Password with Confirm Passowrd", buttonTitle: "Ok") {

                                    }
                    }
                    else {
                        update_Profile()
                    }
                    
                }
                    else {
                        AppManager.init().showAlertSingle(kAppName, message:"Please enter atleast 6 digit password", buttonTitle: "Ok") {

                                    }
                    }
                }
        

                 else {
                    AppManager.init().showAlertSingle(kAppName, message:"newPassword".localized(lang), buttonTitle: "Ok") {

                                }

                }
            } else {
                AppManager.init().showAlertSingle(kAppName, message:"Please Enter your Old Passowrd", buttonTitle: "Ok") {

                            }
               
               
            }
        
        
    }
    func ChangePAssword() {
        
    }
    
    private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_ShowPasswordAction(_ sender: UIButton) {
        if sender.isSelected {
            oldPassowrdTextField.isSecureTextEntry = false
            self.oldPassowrdTextField.RightViewImage(#imageLiteral(resourceName: "icons8-hide-48"))
            
        }
        else {
          
            oldPassowrdTextField.isSecureTextEntry = true
            self.oldPassowrdTextField.RightViewImage(#imageLiteral(resourceName: "icons8-eye-48"))
            
         
            
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btn_ShowNewPasswordAction(_ sender: UIButton) {
        if sender.isSelected {
            newPassowrdTxtFld.isSecureTextEntry = false
            self.newPassowrdTxtFld.RightViewImage(#imageLiteral(resourceName: "icons8-hide-48"))
            btn_ShowPassword.tag = 2
        }
        else {
          
            newPassowrdTxtFld.isSecureTextEntry = true
            self.newPassowrdTxtFld.RightViewImage(#imageLiteral(resourceName: "icons8-eye-48"))
            
            btn_ShowPassword.tag = 1
            
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btn_ShowConfirmPasswordAction(_ sender: UIButton) {
        if sender.isSelected {
            confirmPassowrdTxtFld.isSecureTextEntry = false
            self.confirmPassowrdTxtFld.RightViewImage(#imageLiteral(resourceName: "icons8-hide-48"))
            btn_ShowPassword.tag = 2
        }
        else {
          
            confirmPassowrdTxtFld.isSecureTextEntry = true
            self.confirmPassowrdTxtFld.RightViewImage(#imageLiteral(resourceName: "icons8-eye-48"))
            
            btn_ShowPassword.tag = 1
            
        }
        sender.isSelected = !sender.isSelected
    }
    

func update_Profile(){
    var params =  [String : Any]()
    params["old_password"] = self.oldPassowrdTextField.text ?? ""
    params["password"] = self.newPassowrdTxtFld.text ?? ""
  
    AppManager.init().hudShow()
    ServiceClass.sharedInstance.hitServiceForupdate_Passowrd(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
        print_debug("response: \(parseData)")
        AppManager.init().hudHide()
        if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
            let message = parseData["message"].stringValue
            Common.showAlert(alertMessage: message, alertButtons: ["Ok"]) { (bt) in
                self.navigationController?.popViewController(animated: true)
            }
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

extension ChangePasswordViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == oldPassowrdTextField {
           textField.resignFirstResponder()
            newPassowrdTxtFld.becomeFirstResponder()
        } else if textField == newPassowrdTxtFld {
           textField.resignFirstResponder()
         confirmPassowrdTxtFld.becomeFirstResponder()
        }
       return true
      }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}
