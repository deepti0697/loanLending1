//
//  ToucIDAndTouchFaceVC.swift
//  LoanLending
//
//  Created by deepti on 21/01/21.
//

import UIKit
import BiometricAuthentication

class ToucIDAndTouchFaceVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        BioMetricAuthenticator.shared.allowableReuseDuration = 30
        
        // start authentication
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { [weak self] (result) in
            
            switch result {
            case .success( _):
                
                // authentication successful
                self?.showLoginSucessAlert()
                
            case .failure(let error):
                
                switch error {
                
                // device does not support biometric (face id or touch id) authentication
                case .biometryNotAvailable:
                    self?.showErrorAlert(message: error.message())
                    
                // No biometry enrolled in this device, ask user to register fingerprint or face
                case .biometryNotEnrolled:
                    self?.showGotoSettingsAlert(message: error.message())
                    
                // show alternatives on fallback button clicked
                //                case .fallback:
                //
                ////                    self?.txtUsername.becomeFirstResponder() // enter username password manually
                
                // Biometry is locked out now, because there were too many failed attempts.
                // Need to enter device passcode to unlock.
                case .biometryLockedout:
                    self?.showPasscodeAuthentication(message: error.message())
                    
                // do nothing on canceled by system or user
                case .canceledBySystem, .canceledByUser:
                    break
                    
                // show error for any other reason
                default:
                    
                    self?.showErrorAlert(message: error.message())
                }
            }
        }
    }
    @IBAction func authenticationAction(_ sender: Any) {
        
    }
    func showPasscodeAuthentication(message: String) {
        
        BioMetricAuthenticator.authenticateWithPasscode(reason: message) { [weak self] (result) in
            switch result {
            case .success( _):
                self?.showLoginSucessAlert() // passcode authentication success
            case .failure(let error):
                print(error.message())
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        
        AppManager.init().showAlertSingle(kAppName, message:  message, buttonTitle: "Ok") {
        }
        
        
    }
    
    func showLoginSucessAlert() {
        AppManager.init().showAlertSingle(kAppName, message: "Login successful", buttonTitle: "Success") {
            appdelegate.setHomeView(selectedIndex: 0)
        }
        
    }
    
    func showErrorAlert(message: String) {
        AppManager.init().showAlertSingle(kAppName, message: "Login Failed", buttonTitle: "Error") {
        }
        
    }
    func showGotoSettingsAlert(message: String) {
        AppManager.init().showAlertSingle(kAppName, message: "Go to Settings", buttonTitle: "Ok") {
            
            // open settings
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
            
        }
        
    }
}
