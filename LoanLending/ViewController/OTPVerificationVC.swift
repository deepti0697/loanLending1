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
    
    @IBOutlet weak var lbl_expireTime: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var xdontRecveOtpLbl: UILabel!
    @IBOutlet weak var mobileNOLbl: UILabel!
    @IBOutlet weak var enterDigitLbl: UILabel!
    @IBOutlet weak var verifictnCodeLbl: UILabel!
    @IBOutlet weak var vwSVP: SVPinView!
    @IBOutlet weak var lblPhone: UILabel!
    var type = ""
    var countryCode: String = ""
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    var phonenumber = ""
    var timer: Timer?
    var totalTime = 120
    
    var isResendBtnClick = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startOtpTimer()
        vwSVP.style = .none
        vwSVP.pinLength = 4
        vwSVP.style = .box
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.mobileNOLbl.text = "\(countryCode) \(self.phonenumber)"
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if type != "forget" {
            
        }
        getOTP()
        self.resendOtpBtn.isEnabled = false
    }
    
    func localizeSetup(){
        self.verifictnCodeLbl.text = ("verificationCode".localized(lang))
        self.enterDigitLbl.text = ("pleaseEnterOTP".localized(lang))
        self.confirmBtn.setTitle("confirm", for: .normal)
        self.xdontRecveOtpLbl.text = ("dont_have_an_Account".localized(lang))
        resendOtpBtn.setTitle("resendOTP".localized(lang), for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        self.resendOtpBtn.isUserInteractionEnabled = true
    }
    
    @IBAction func btnResendAction(_ sender: Any) {
        
        self.isResendBtnClick = true
        timer?.invalidate()
        self.resendOtpBtn.isUserInteractionEnabled = true
        vwSVP.refreshView()
        getOTP()
//        confirmBtn.isEnabled = true
//        self.startOtpTimer()
        
    }
    private func startOtpTimer() {
        self.resendOtpBtn.isUserInteractionEnabled = false
            self.totalTime = 120
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }

    @objc func updateTimer() {
            print(self.totalTime)
            self.lbl_expireTime.text = self.timeFormatted(self.totalTime) // will show timer
            if totalTime != 0 {
                totalTime -= 1  // decrease counter timer
            } else {
                if let timer = self.timer {
                    timer.invalidate()
                    self.resendOtpBtn.isUserInteractionEnabled = true
                    self.timer = nil
//                    confirmBtn.isEnabled = false
                    
                }
            }
        }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "Expired in %02d:%02d", minutes, seconds)
    }
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if ((timer?.isValid) != nil) {
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
        else {
            AppManager.init().showAlertSingle(kAppName, message:  "Your OTP is Expire now, Please Resend Otp again.", buttonTitle: "Ok") {

                        }
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
                if self.isResendBtnClick {
                    let message = parseData["message"].stringValue
                    Common.showAlert(alertMessage: message , alertButtons: ["Ok"]) { (bt) in
                        self.startOtpTimer()
                    }
                }
                else{
                    
                }
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
        params["type"] = self.type
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForOTPVerify(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                print("OTP Send")
                self.timer?.invalidate()
                self.resendOtpBtn.isUserInteractionEnabled = true
//                Common.showAlert(alertMessage: parseData["message"].stringValue, alertButtons: ["Ok"]) { (bt) in
                    if self.type == "login" {
                        
                        self.openViewController(controller: LoginViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                        
                           })
                    }
                    else {
                self.openViewController(controller: UpdatePasswordViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                    vc.phoneNumber = self.phonenumber
                   })
                }
                }
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
    
    
    

