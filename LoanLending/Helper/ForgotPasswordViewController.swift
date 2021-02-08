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
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var weAreHeretoHelpYouLbl: UILabel!
    @IBOutlet weak var emailPlaceholderTextField: UITextField!
    @IBOutlet weak var forgotPassword: UILabel!
    
    @IBOutlet weak var emailTextFeild: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
//        self.showActivityIndicator(sMessage: "Loading")
//        let email = emailTextFeild.text ?? ""
//        let parameters = ["email" : email]
//        let head = ["Content-Type":"application/json",
//                    "Accept" :"application/json"]
//        NetworkManager.post_Request2(urlService: kForgotPassword, param: parameters as [String : Any], head: head) { (response) in
//            self.hideActivityIndicator()
//            do {
//                let response = try JSON(data:  response as! Data)
//                let jsonStatus = response["status"].intValue
//                let jsonMessage = response["message"].stringValue
//                if jsonStatus == 1 {
//
//                    self.navigationController?.popViewController(animated: true)
//                    self.view.makeToast(message: "Reset Email Sent")
//                }
//                else {
//                    self.view.makeToast(message: jsonMessage)
//                }
//            }
//            catch {
//                Loader.showAlert(message: "Internal Error")
//            }
//        }
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
//        forgotPasswordAction()
    }
    @IBAction func backToLoginPage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
}



