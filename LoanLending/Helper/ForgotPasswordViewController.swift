//
//  ForgotPasswordViewController.swift
//  DreamTeam
//
//  Created by Test on 08/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON
class ForgotPasswordViewController: UIViewController {
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var forgotPassword: UILabel!
    @IBOutlet weak var emailTextFeild: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextFeild.delegate = self
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    /// Basic UI Setup
    func setup() {
//        forgotPassword.text = StringConstant.forgotPassword
//        weAreHeretoHelpYouLbl.text = StringConstant.weHereToHelpYou
//        weAreHeretoHelpYouLbl.textColor = UIColor.FlatColor.Grey.DarkGrey
//        emailPlaceholderTextField.borderStyle = .none
//        emailTextFeild.borderStyle = .none
//        emailTextFeild.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor.FlatColor.Grey.DarkGrey, width: 1)
//        emailPlaceholderTextField.textColor = UIColor.FlatColor.Grey.DarkGrey
//        nextBtn.setTitle(StringConstant.next, for: .normal)
//        nextBtn.backgroundColor = UIColor.FlatColor.Blue.GreenishBlue
//        nextBtn.setTitleColor(UIColor.FlatColor.white.whitecolor, for: .normal)
        
    }
   
    
    /// ForgotPassword Api
    fileprivate func forgotPasswordAction() {
        if emailTextFeild.text != ""   {
            if emailTextFeild.text?.count == 10 {
                self.getOTP()
       
        }
            else {
                AppManager.init().showAlertSingle(kAppName, message:"Please enter valid mobile number.", buttonTitle: "Ok") {

                            }
            }
        }
        else {
            AppManager.init().showAlertSingle(kAppName, message:"Valid_NUMBER".localized(lang), buttonTitle: "Ok") {

                        }
        }
//        var params =  [String : Any]()
//        params["old_password"] = self.oldPassowrdTextField.text ?? ""
//        params["password"] = self.newPassowrdTxtFld.text ?? ""
//      
//        AppManager.init().hudShow()
//        ServiceClass.sharedInstance.hitServiceForupdate_Passowrd(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
//            print_debug("response: \(parseData)")
//            AppManager.init().hudHide()
//            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
//                let message = parseData["message"].stringValue
//                Common.showAlert(alertMessage: message, alertButtons: ["Ok"]) { (bt) in
//                    self.navigationController?.popViewController(animated: true)
//                }
//                }
//             else {
//                
//                guard let dicErr = errorDict?["msg"] as? String else {
//                    return
//                }
//                Common.showAlert(alertMessage: (dicErr), alertButtons: ["Ok"]) { (bt) in
//                }
//                
//                
//            }
//        })
        
    }
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        forgotPasswordAction()
    }
    @IBAction func backToLoginPage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}

extension ForgotPasswordViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    func getOTP(){
       
        var params =  [String : Any]()
       
        params["mobile"]  = self.emailTextFeild.text
       
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForOTPSend(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                self.openViewController(controller: OTPVerificationVC.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                    vc.phonenumber = self.emailTextFeild.text ?? ""
                    vc.type = "forget"
                    
            })
            }
//                else{
//
//                }
//                print("OTP Send")
//
//                }
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

