//
//  SignupSecondVC.swift
//  LoanLending
//
//  Created by deepti on 13/01/21.
//

import UIKit
import SwiftyJSON
import ActionSheetPicker_3_0
class SignupSecondVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var countryCodeTxt: UITextField!
    var staffID:String?
    var fullName:String?
    var gender:String?
    var companyName:String?
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    var initalValue = 0
    var langugae = [LanguageDTo](){
        didSet {
            if langugae.count > 0 {
                self.countryCodeTxt.text = "+\(langugae[0].code ?? "")"
            }
        }
    }
    
    @IBOutlet weak var btn_ShowPassword: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var passowrdTxt: UITextField!
    @IBOutlet weak var passowrdLbl: UILabel!
    @IBOutlet weak var mblTxt: UITextField!
    @IBOutlet weak var mobileLblx: UILabel!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var signupLbl: UILabel!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalized()
        openCountryCode()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.passowrdTxt.RightViewImage(UIImage.init(named: "password-view-1"))
        self.cityTxt.delegate = self
        self.mblTxt.delegate = self
        self.passowrdTxt.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.mblTxt.setLeftPaddingPoints(5.0)
        setupTextField()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func setupTextField(){
        let color = UIColor.white
        let placeholder = passowrdTxt.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        passowrdTxt.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
       
        let placeholder2 = mblTxt.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        mblTxt.attributedPlaceholder = NSAttributedString(string: placeholder2, attributes: [NSAttributedString.Key.foregroundColor : color])
        let placeholder3 = cityTxt.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        cityTxt.attributedPlaceholder = NSAttributedString(string: placeholder3, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    func setupLocalized(){
        self.signupLbl.text = ("signup".localized(lang))
        self.cityLbl.text = ("city".localized(lang))
        self.mobileLblx.text = ("mobileNo".localized(lang))
        self.passowrdLbl.text = ("password".localized(lang))
        
        self.cityTxt.placeholder = ("enterCity".localized(lang))
        mblTxt.placeholder  = "enterMblNo".localized(lang)
        passowrdTxt.placeholder = "enterPasswrd".localized(lang)
        self.nextBtn.setTitle("next".localized(lang), for: .normal)
        
        
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func openCountryCode(_ sender: Any) {
    showTimeSheet(textField: countryCodeTxt)
    }
    
    @IBAction func btn_ShowPasswordAction(_ sender: UIButton) {
        if btn_ShowPassword.tag == 1 {
            passowrdTxt.isSecureTextEntry = false
            self.passowrdTxt.RightViewImage(UIImage.init(named: "password_icon-1"))
            btn_ShowPassword.tag = 2
        }
        else {
          
            passowrdTxt.isSecureTextEntry = true
            self.passowrdTxt.RightViewImage(UIImage.init(named: "password-view-1"))
            
            btn_ShowPassword.tag = 1
            
        }
    }
    func showTimeSheet(textField : UITextField){
        let array = self.langugae.map{$0.code}
        let placeHolder = "List"
        let customStringPicker = ActionSheetStringPicker.init(title:placeHolder, rows: array as [Any], initialSelection:initalValue, doneBlock:
        { picker, values, indexes in
            textField.text = (String(describing: indexes ?? ""))
            self.initalValue = values
            return
        }, cancel: nil, origin: textField)
        customStringPicker!.tapDismissAction = TapAction.cancel
        self.view.endEditing(true)
        customStringPicker!.show()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if cityTxt.text != "" {
            if mblTxt.text != "" {
                if passowrdTxt.text != "" {
                    var params =  [String : Any]()
                    
                    params["mobile"] = self.mblTxt.text ?? ""
                    AppManager.init().hudShow()
                    ServiceClass.sharedInstance.hitServiceForcheckMobileREgistered(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
                        print_debug("response: \(parseData)")
                        AppManager.init().hudHide()
                        if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                            self.openViewController(controller: SignUpThirdVC.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                                vc.staffID = self.staffID
                                vc.companyName = self.companyName
                                vc.gender = self.gender
                                vc.fullName = self.fullName
                                vc.city = self.cityTxt.text ?? ""
                                vc.mobile = self.mblTxt.text ?? ""
                                vc.password = self.passowrdTxt.text ?? ""
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
                else {
                    Common.showAlert(alertMessage: "Please enter password".localized(lang), alertButtons: ["Ok"]) { (bt) in
                    }
                }
           
            }else {
                Common.showAlert(alertMessage: "Please enter mobile number".localized(lang), alertButtons: ["Ok"]) { (bt) in
                }
            }
        }
        else {
            Common.showAlert(alertMessage: "Please Enter your City".localized(lang), alertButtons: ["Ok"]) { (bt) in
            }
        }
       
        
    }
    func openCountryCode(){
        let params =  [String : Any]()
       
        
       
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForCountryCode(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let countries = parseData["data"]
                for obj in countries["countries"].arrayValue {
                   let comObj = LanguageDTo(fromJson:obj)
                    self.langugae.append(comObj)
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
extension SignupSecondVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == cityTxt {
           textField.resignFirstResponder()
            mblTxt.becomeFirstResponder()
        } else if textField == mblTxt {
           textField.resignFirstResponder()
         passowrdTxt.becomeFirstResponder()
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
