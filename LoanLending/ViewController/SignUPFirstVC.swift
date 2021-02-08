//
//  SignUPFirstVC.swift
//  LoanLending
//
//  Created by deepti on 13/01/21.
//

import UIKit

class SignUPFirstVC: UIViewController {

    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var femaleImageView: UIImageView!
    @IBOutlet weak var maleImageView: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var companyNameTxt: UITextField!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var femaleLbl: UILabel!
    @IBOutlet weak var maleLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var staffIdTxt: UITextField!
    @IBOutlet weak var staffIdLbl: UILabel!
    @IBOutlet weak var signupLbl: UILabel!
    
    var isMaleButtonSelected: Bool = true {
        didSet {
            if isMaleButtonSelected {
               
                self.femaleImageView.image = #imageLiteral(resourceName: "Uncheck-1")
                self.maleImageView.image = #imageLiteral(resourceName: "check@1")

            } else {
                self.femaleImageView.image = #imageLiteral(resourceName: "check@1")
                self.maleImageView.image = #imageLiteral(resourceName: "Uncheck-1")
            }
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalized()
        self.staffIdTxt.delegate = self
        self.fullNameTxt.delegate = self
        self.companyNameTxt.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    func setupTextField(){
        let color = UIColor.white
        let placeholder = companyNameTxt.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        companyNameTxt.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
       
        let placeholder2 = fullNameTxt.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        fullNameTxt.attributedPlaceholder = NSAttributedString(string: placeholder2, attributes: [NSAttributedString.Key.foregroundColor : color])
        let placeholder3 = staffIdTxt.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        staffIdTxt.attributedPlaceholder = NSAttributedString(string: placeholder3, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    func setupLocalized(){
        self.signupLbl.text = ("signup".localized(lang))
        self.staffIdLbl.text = ("staffID".localized(lang))
        self.fullNameLbl.text = ("fullName".localized(lang))
        self.genderLbl.text = ("gender".localized(lang))
        self.maleLbl.text = ("male".localized(lang))
        self.femaleLbl.text = ("female".localized(lang))
        self.companyNameLbl.text = ("compnayName".localized(lang))
        self.staffIdTxt.placeholder = ("enterHere".localized(lang))
        fullNameTxt.placeholder  = "enterName".localized(lang)
        companyNameTxt.placeholder = "enterCompanyName".localized(lang)
        self.nextBtn.setTitle("next".localized(lang), for: .normal)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTextField()
        setupLocalized()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @IBAction func femaleBtnAction(_ sender: Any) {
        isMaleButtonSelected = false
    }
    
    @IBAction func maleBtnAction(_ sender: Any) {
        isMaleButtonSelected = true
        
    }
   
   
    @IBAction func nexAction(_ sender: Any) {
      
        if   self.fullNameTxt.text?.trimmingCharacters(in: .whitespaces).count != 0 {
                openViewController(controller: SignupSecondVC.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                    vc.staffID = self.staffIdTxt.text ?? ""
                    vc.companyName = self.companyNameTxt.text ?? ""
                    if self.isMaleButtonSelected {
                        vc.gender = "male"
                    }
                    else {
                        vc.gender = "female"
                    }
                    vc.fullName = self.fullNameTxt.text ?? ""
            })
            }
            else{
                AppManager.init().showAlertSingle(kAppName, message:  "Please enter full name".localized(lang), buttonTitle: "Ok") {
                }
            }
        }
        
       
        }
    


extension SignUPFirstVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == staffIdTxt {
           textField.resignFirstResponder()
            fullNameTxt.becomeFirstResponder()
        } else if textField == fullNameTxt {
           textField.resignFirstResponder()
         companyNameTxt.becomeFirstResponder()
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
