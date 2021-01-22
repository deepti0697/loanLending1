//
//  ChooseLanguageVc.swift
//  LoanLending
//
//  Created by deepti on 13/01/21.
//

import UIKit
import ActionSheetPicker_3_0
class ChooseLanguageVc: BaseViewController {

    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var choseLangTiltleLb: UILabel!
    var serviceInitialValue = 0
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var langTxtFeild: UITextField!
    var selectedCat = ""
    var langArray = ["English","French"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.langTxtFeild.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
        // Do any additional setup after loading the view.
    }
    func setup(){
        if #available(iOS 13.0, *) {
            self.langTxtFeild.RightViewImage(UIImage.init(named: "arrow-point-to-right (1)")?.withTintColor(.white))
        } else {
            self.langTxtFeild.RightViewImage(UIImage.init(named: "arrow-point-to-right (1)"))
            // Fallback on earlier versions
        }
        
        self.langTxtFeild.LeftView(of: UIImage.init(named: "arrow-point-to-right (1)"))
        self.langTxtFeild.setLeftPaddingPoints(5.0)
        let color = UIColor.white
        let placeholder = langTxtFeild.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        langTxtFeild.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
//        self.langTxtFeild.layer.borderColor = UIColor.white.cgColor
//        self.langTxtFeild.layer.borderWidth = 1
        self.langTxtFeild.text = "English"
        AppHelper.setStringForKey("en", key: ServiceKeys.languageType)
    }
 
    func showActionSheet(textField : UITextField) {
        
        if textField == langTxtFeild {
            let rowsArray = self.langArray
            let placeHolder = "Service"

            let customStringPicker = ActionSheetStringPicker.init(title:placeHolder, rows: rowsArray as [Any], initialSelection: serviceInitialValue, doneBlock:
            { picker, values, indexes in
                textField.text = (String(describing: indexes!))
                self.selectedCat = self.langArray[values]
                self.serviceInitialValue = values
                if self.selectedCat == "English" {
                    AppHelper.setStringForKey("en", key: ServiceKeys.languageType)
                }
                else {
                    AppHelper.setStringForKey("fr", key: ServiceKeys.languageType)
                }
               
                return
            }, cancel: nil, origin: textField)
            customStringPicker!.tapDismissAction = TapAction.cancel
            self.view.endEditing(true)
            customStringPicker!.show()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func proceedAction(_ sender: Any) {
        self.openViewController(controller: ViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
           })
        
//        appdelegate.setHomeView()
    }
}
extension ChooseLanguageVc : UITextFieldDelegate {
    
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showActionSheet(textField : textField)
            return false
      
       }
}
