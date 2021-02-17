//
//  ContactUsViewController.swift
//  LoanLending
//
//  Created by deepti on 17/02/21.
//

import UIKit
import SwiftyJSON
class ContactUsViewController: UIViewController,UITextViewDelegate{
    let placeholderLabel = UILabel()
   
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var nextBtnAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        placeholderLabel.text = "Type a Message..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (txtView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        txtView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !txtView.text.isEmpty
        self.txtView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func contactUS(){
        
        var params =  [String : Any]()
       
        params["message"]  = self.txtView.text ?? ""
      
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceContactUS(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                Common.showAlert(alertMessage: parseData["message"].stringValue, alertButtons: ["Ok"]) { (bt) in
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
    @IBAction func bcakButnACtion(_ sender: Any) {
        appdelegate.setHomeView(selectedIndex: appdelegate.tabBarController.selectedIndex)
    }
    func textViewDidChange(_ textView: UITextView) {
          placeholderLabel.isHidden = !txtView.text.isEmpty
      }
    @IBAction func contactUsAction(_ sender: Any) {
        if txtView.text == ""{
            Common.showAlert(alertMessage: "Please Enter your message", alertButtons: ["Ok"]) { (bt) in
            }
        }
        else {
            self.contactUS()
        }
       
    }
}
