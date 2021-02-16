//
//  UpdatePasswordViewController.swift
//  LoanLending
//
//  Created by deepti on 10/02/21.
//

import UIKit
import SwiftyJSON
class UpdatePasswordViewController: UIViewController {


    var phoneNumber = ""
    @IBOutlet weak var btn_New_ShowPassword: UIButton!
    @IBOutlet weak var btn_Confirm_Show_Password: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
   
    @IBOutlet weak var confirmPasswordLocLbl: UILabel!
    @IBOutlet weak var newPasswordLocLbl: UILabel!
    
    @IBOutlet weak var changeLbl: UILabel!
    @IBOutlet weak var confirmPassowrdTxtFld: UITextField!
    @IBOutlet weak var newPassowrdTxtFld: UITextField!
    
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var txt_Password: UITextField!
      var checkFromupdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.confirmPassowrdTxtFld.RightViewImage1(#imageLiteral(resourceName: "password_icon-1"), width: 25, height: 25)
        self.newPassowrdTxtFld.RightViewImage1(#imageLiteral(resourceName: "password_icon-1"), width: 25, height: 25)
        self.confirmPassowrdTxtFld.delegate = self
        self.newPassowrdTxtFld.delegate = self
        self.confirmPassowrdTxtFld.textColor = .black
        self.newPassowrdTxtFld.textColor = .black
        
        setupLocalizable()
    }
    
    func setupLocalizable(){
        self.newPasswordLocLbl.text = "New Password".localized(lang)
        self.newPasswordLocLbl.text = "New Password".localized(lang)
        self.confirmPasswordLocLbl.text = "Confirm Password".localized(lang)
        self.nextBtn.setTitle("Update Password".localized(lang), for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    
    
    @IBAction func backtoForgotPasswordScreen(_ sender: Any) {
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ForgotPasswordViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    @IBAction func savePasswordBtn(_ sender: Any) {
      
//
                if newPassowrdTxtFld.text != "" {
                    
                    if (newPassowrdTxtFld.text?.count)! > 6 {
                    if confirmPassowrdTxtFld.text != newPassowrdTxtFld.text {
                        AppManager.init().showAlertSingle(kAppName, message:"Please match new Password with Confirm Passowrd", buttonTitle: "Ok") {

                                    }
                    }
                    else {
                        update_Profile()
                    }
                    
                }
                    else {
                        AppManager.init().showAlertSingle(kAppName, message:"Please enter atleast 7 digit password", buttonTitle: "Ok") {

                                    }
                    }
                }
        

                 else {
                    AppManager.init().showAlertSingle(kAppName, message:"newPassword".localized(lang), buttonTitle: "Ok") {

                                }

                }
            }
        
        
    
    func ChangePAssword() {
        
    }
    
    private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    @IBAction func btn_ShowNewPasswordAction(_ sender: UIButton) {
        if sender.isSelected {
            newPassowrdTxtFld.isSecureTextEntry = true
            self.newPassowrdTxtFld.RightViewImage1(#imageLiteral(resourceName: "password_icon-1"), width: 25, height: 25)
            
        }
        else {
          
            newPassowrdTxtFld.isSecureTextEntry = false
            self.newPassowrdTxtFld.RightViewImage1(#imageLiteral(resourceName: "password-view-1"), width: 25, height: 25)
            
           
            
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func btn_ShowConfirmPasswordAction(_ sender: UIButton) {
        if sender.isSelected {
            confirmPassowrdTxtFld.isSecureTextEntry = true
            self.confirmPassowrdTxtFld.RightViewImage1(#imageLiteral(resourceName: "password_icon-1"), width: 25, height: 25)
           
        }
        else {
          
            confirmPassowrdTxtFld.isSecureTextEntry = false
            self.confirmPassowrdTxtFld.RightViewImage1(#imageLiteral(resourceName: "password-view-1"), width: 25, height: 25)
         
            
        }
        sender.isSelected = !sender.isSelected
    }
    

func update_Profile(){
    var params =  [String : Any]()
    params["mobile"] = self.phoneNumber
    params["password"] = self.newPassowrdTxtFld.text ?? ""
  
    AppManager.init().hudShow()
    ServiceClass.sharedInstance.hitServiceForNewe_Passowrd(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
        print_debug("response: \(parseData)")
        AppManager.init().hudHide()
        if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
            let message = parseData["message"].stringValue
            Common.showAlert(alertMessage: message, alertButtons: ["Ok"]) { (bt) in
                self.openViewController(controller: LoginViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                
                   })
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

extension UpdatePasswordViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
         if textField == newPassowrdTxtFld {
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
