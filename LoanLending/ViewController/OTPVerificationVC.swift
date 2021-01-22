//
//  OTPVerificationVC.swift
//  FITPAS
//
//  Created by octal on 24/01/19.
//  Copyright © 2019 octal. All rights reserved.
//

import UIKit
import SVPinView
import SwiftyJSON
class OTPVerificationVC: UIViewController {
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var xdontRecveOtpLbl: UILabel!
    @IBOutlet weak var mobileNOLbl: UILabel!
    @IBOutlet weak var enterDigitLbl: UILabel!
    @IBOutlet weak var verifictnCodeLbl: UILabel!
    @IBOutlet weak var vwSVP: SVPinView!
    @IBOutlet weak var lblPhone: UILabel!
    
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    var phonenumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        vwSVP.style = .none
        vwSVP.pinLength = 4
        vwSVP.style = .box
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.mobileNOLbl.text = self.phonenumber
        getOTP()
    }
    
    func localizeSetup(){
        self.verifictnCodeLbl.text = ("verificationCode".localized(lang))
        self.enterDigitLbl.text = ("pleaseEnterOTP".localized(lang))
        self.confirmBtn.setTitle("confirm", for: .normal)
        self.xdontRecveOtpLbl.text = ("dont_have_an_Account".localized(lang))
        resendOtpBtn.setTitle("resendOTP".localized(lang), for: .normal)
    }
    
    @IBAction func btnResendAction(_ sender: Any) {
        
        
    }
    
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        
        var userInfo = [String: Any]()
//        openViewController(controller: ChooseLanguageVc.self, storyBoard: .mainStoryBoard, handler: { (vc) in
//    })
        if vwSVP.getPin().count < 4 {

                            AppManager.init().showAlertSingle(kAppName, message:  "Please enter valid OTP.", buttonTitle: "Ok") {

                                        }
        } else {
            userInfo["otp"] = vwSVP.getPin()
            verifyOTP(otp:vwSVP.getPin())
//            self.navigationController?.popViewController(animated: true)
        }
    }
    func getOTP(){
        var params =  [String : Any]()
       
        params["mobile"]  = self.phonenumber
       
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForOTPSend(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                print("OTP Send")
              
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
    func verifyOTP(otp:String)
    {
        var params =  [String : Any]()
       
        params["mobile"]  = self.phonenumber
        params["otp"] = otp
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForOTPVerify(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                print("OTP Send")
                self.openViewController(controller: LoginViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                   })
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
    
    
    

