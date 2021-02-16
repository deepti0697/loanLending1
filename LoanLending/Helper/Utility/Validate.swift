//
//  Validate.swift
//  Maxillofacia
//
//  Created by apple on 11/05/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit

class Validate: NSObject {
    static let  shared =  Validate()
    var validation = Validation()
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    
    func showMessage(message:String){
     
        Common.showAlert(alertMessage: message, alertButtons: ["Ok"]) { (btn) in
        }
    }
    
    //Validate login form
        func validateLogin(vc:SignUpThirdVC) -> Bool {
            if vc.emailTxt.text?.trimmingCharacters(in: .whitespaces).count == 0  {
                self.showMessage(message: "enterEmail".localized(lang))
           
              
                return false
            } else if ( !validation.emailValidation(txtFieledEmail: vc.emailTxt.text!) ) {

                self.showMessage(message: "EMAIL_INVALID".localized(lang))
             
                return false

            }
            else if vc.document.isEmpty {
                self.showMessage(message: "Please add your id".localized(lang))
                return false
            }
            else if !vc.isAcceptTermCondition {
                self.showMessage(message:"AcceptTermAndCondition".localized(lang))
                return false
            }
            else {
                return true
            }
        }
            /// validate Submit loan VC
            
            func validateSubmitLoanPage(vc:LoanRequestViewController) -> Bool {
                if vc.purposeOfLoanTxxtfld.text?.trimmingCharacters(in: .whitespaces).count == 0  {
                    self.showMessage(message: "Enter purpose of loan".localized(lang))
               
                  
                    return false
                } else if vc.bankNameTxtFld.text?.trimmingCharacters(in: .whitespaces).count == 0 {

                    self.showMessage(message: "Enter your bank name".localized(lang))
                 
                    return false

                }
                else if vc.selectMobileWalletTxt.text?.trimmingCharacters(in: .whitespaces).count == 0 {
                    self.showMessage(message: "Please select your wallet type".localized(lang))
                 
                    return false
                }
               
                else if vc.document.isEmpty {
                    self.showMessage(message: "SalarySlip".localized(lang))
                    return false
                }
                else if !vc.isAcceptTermCondition {
                    self.showMessage(message: "AcceptTermAndCondition".localized(lang))
                    return false
                }
                else {
                    return true
                }
            

    //Validate Forgot form
//    func validateForgotPassword(vc:ForgotPasswordViewController) -> Bool {
//        if vc.txtEmail.text?.trimmingCharacters(in: .whitespaces).count == 0  {
//            //            self.showMessage(message: Messages.EMAIL_Err.rawValue)
//            self.showMessage(message: Messages.EMAIL_EMPTY_ID.rawValue)
//            return false
//        } else if  !validation.emailValidation(txtFieledEmail: vc.txtEmail.text!)  {
//
//            self.showMessage(message: Messages.EMAIL_INVALID_ID.rawValue)
//            return false
//        }
//        else  {
//            return true
//        }
//    }
//
//
//    //Validate Forgot form
//     func validateForgotPassword(vc:ForgotViewController) -> Bool {
//             if vc.txtEmail.text?.trimmingCharacters(in: .whitespaces).count == 0  {
//     //            self.showMessage(message: Messages.EMAIL_Err.rawValue)
//                 vc.txtEmail.showErrorWithText(errorText: Messages.EMAIL_Err.rawValue)
//
//                 return false
//             } else if  validation.emailValidation(txtFieledEmail: vc.txtEmail.text!)  {
//                  vc.txtEmail.showErrorWithText(errorText: Messages.EMAIL_INVALID.rawValue)
//     //            self.showMessage(message: Messages.EMAIL_INVALID.rawValue)
//                 return false
//             }
//             else  {
//                 return true
//             }
//          }
//    
//     func validateLookingFOr(vc:LookingTutorViewController) -> Bool {
////            if vc.txtEmail.text?.trimmingCharacters(in: .whitespaces).count == 0  {
////    //            self.showMessage(message: Messages.EMAIL_Err.rawValue)
////                vc.txtEmail.showErrorWithText(errorText: Messages.EMAIL_Err.rawValue)
////
////                return false
////            } else if  validation.emailValidation(txtFieledEmail: vc.txtEmail.text!)  {
////                 vc.txtEmail.showErrorWithText(errorText: Messages.EMAIL_INVALID.rawValue)
////    //            self.showMessage(message: Messages.EMAIL_INVALID.rawValue)
////                return false
////            }
////            else  {
//                return true
////            }
//         }
//    
//    
//    
//       //Validate login form
//       func validateSendMessage(vc:SendMessageViewController) -> Bool {
//        if vc.txtName.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            //            self.showMessage(message: Messages.NAME_EMPTY.rawValue)
//            vc.txtName.showErrorWithText(errorText: Messages.NAME_EMPTY.rawValue)
//            return false
//        } else  if (vc.txtName.text?.trimmingCharacters(in: .whitespaces).count)! < 2 {
//            //            self.showMessage(message: Messages.FULL_NAME_LENGTH.rawValue)
//            vc.txtName.showErrorWithText(errorText: Messages.FULL_NAME_LENGTH.rawValue)
//            return false
//        }
//        else  if vc.txtSubject.text?.trimmingCharacters(in: .whitespaces).count == 0  {
//            //            self.showMessage(message: Messages.PASSWORD_EMPTY.rawValue)
//            vc.txtSubject.showErrorWithText(errorText: Messages.Subject_Err.rawValue)
//            return false
//        } else if vc.txtEmail.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            //            self.showMessage(message: Messages.EMAIL_EMPTY.rawValue)
//            vc.txtEmail.showErrorWithText(errorText: Messages.EMAIL_EMPTY.rawValue)
//            
//            return false
//        }else if !validation.emailValidation(txtFieledEmail: vc.txtEmail.text!) {
//            //            self.showMessage(message: Messages.EMAIL_INVALID.rawValue)
//            vc.txtEmail.showErrorWithText(errorText: Messages.EMAIL_INVALID.rawValue)
//            return false
//        }  else if vc.txtPhone.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//                     vc.txtPhone.showErrorWithText(errorText: Messages.PHONE_EMPTY.rawValue)
//                    return false
//                }
//                    else  if ( (((vc.txtPhone.text?.trimmingCharacters(in: .whitespaces).count)! < 10) || (((vc.txtPhone.text?.trimmingCharacters(in: .whitespaces).count)! > 14))))   {
//        //                self.showMessage(message: Messages.PHONE_INVALID.rawValue)
//                    vc.txtPhone.showErrorWithText(errorText: Messages.PHONE_INVALID.rawValue)
//                        return false
//                    }
//        else if vc.txtVwMsge.text.trimmingCharacters(in: .whitespacesAndNewlines) == "Message" && vc.txtVwMsge.textColor == UIColor.lightGray {
//             self.showMessage(message: Messages.QUERY_message.rawValue)
//            return false
//        }
//        else {
//            return true
//        }
//       }
//       
//    
//    //Validate login form
//    func validateReviewMessage(vc:WriteReviewViewController) -> Bool {
//     if vc.txtTitle.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//         //            self.showMessage(message: Messages.NAME_EMPTY.rawValue)
//         vc.txtTitle.showErrorWithText(errorText: Messages.TITLE_EMPTY.rawValue)
//         return false
//     }
//     else if vc.txtVwReview.text.trimmingCharacters(in: .whitespacesAndNewlines) == "Review" && vc.txtVwReview.textColor == UIColor.lightGray {
//          self.showMessage(message: Messages.QUERY_Review.rawValue)
//         return false
//     }
//     else {
//         return true
//     }
//    }
    
   
//
    //Validate Change password form
//    func validateChangePassword(vc:ResetPasswordViewController) -> Bool {
//        if vc.txtOTP.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.OLD_PASSWORD_EMPTY.rawValue)
//            return false
//        }else if vc.txtNewPassword.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.NEW_PASSWORD_EMPTY.rawValue)
//            return false
//        }else if vc.txtConfirmPassword.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.CONFIRM_PASSWORD_EMPTY.rawValue)
//            return false
//        }else if !validation.PasswordAndConfirmPasswordMatch(txtfieldone: vc.txtNewPassword.text!, secondValue: vc.txtConfirmPassword.text!) {
//            self.showMessage(message: Messages.PASSWORD_DIFFERENT.rawValue)
//            return false
//        }else {
//            return true
//        }
//    }
//
//    //Validate Complaint
  
//
//    //Validate Edit Profile form
//    func validateEditProfile(vc:ProfileViewController) -> Bool {
//        if !vc.txtFullName.hasText {
//            self.showMessage(message: Messages.NAME_EMPTY.rawValue)
//            return false
//        }else if !vc.txtPhoneNumber.hasText {
//            self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
//            return false
//        } else {
//            return true
//        }
//    }
//
//    //Validate Billing Address Payment
//    func validateBillingAddressForPayment(vc:PaymentSummeryViewController) -> Bool {
//
//       if vc.txtCardType.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.CARD_TYPE.rawValue)
//            return false
//        } else  if vc.txtCard1.text!.trimmingCharacters(in: .whitespaces).count  == 0 {
//            self.showMessage(message: Messages.CARD_EMPTY.rawValue)
//            return false
//        } else  if vc.txtCard1.text!.trimmingCharacters(in: .whitespaces).count < 16 {
//            self.showMessage(message: Messages.CARD_LENGTH.rawValue)
//            return false
//        } else  if vc.txtCVC.text!.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.CARD_CVV.rawValue)
//            return false
//        } else  if vc.txtExpireDate.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.EXPIRY_DATE.rawValue)
//            return false
//       } else if vc.imgPhoto.image == UIImage(named: "placeholder") {
//         self.showMessage(message: Messages.LOCAL_ID.rawValue)
//         return false
//       }
//       else if vc.imgID.image == UIImage(named: "placeholder") {
//         self.showMessage(message: Messages.Photo_ID.rawValue)
//         return false
//       }
//       else if vc.txtPCode.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//        self.showMessage(message: Messages.PHONE_Code.rawValue)
//        return false
//       }
//       else if vc.txtPhone.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//        self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
//        return false
//       }    else if vc.txtPhone.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 10 {
//        self.showMessage(message: Messages.PHONE_INVALID.rawValue)
//        return false
//       }
//       else if vc.txtVwAddressL1.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.ADD_LINE1.rawValue)
//            return false
//        }
//            //        else if vc.txtVwAddressL1.text?.trim() == "" {
//            //            AppAlerts.showMessage(alertMessage: Messages.ADD_LINE2.rawValue)
//            //            return false
//            //        }
//        else if  vc.txtCity.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.CITY_EMPTY.rawValue)
//            return false
//        }
//        else if  vc.txtCity.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 3 {
//            self.showMessage(message: Messages.CITY_LENGTH.rawValue)
//            return false
//        }
//        else if  vc.txtPost.text?.trimmingCharacters(in: .whitespaces).count ?? 0 == 0 {
//            self.showMessage(message: Messages.POSTAL_EMPTY.rawValue)
//            return false
//        }
//        else if  vc.txtPost.text?.trimmingCharacters(in: .whitespaces).count ?? 0  < 3 {
//            self.showMessage(message: Messages.POSTAL_LENGTH.rawValue)
//            return false
//        }
//
//        else if  vc.txtCountry.text?.trimmingCharacters(in: .whitespaces).count ?? 0 == 0 {
//            self.showMessage(message: Messages.COUNTRY_EMPTY.rawValue)
//            return false
//        }
//
//        else {
//            return true
//        }
//    }
//
//    //Validate card
//
//    func validateBillingAddressForPayment(vc:PaymentViewController) -> Bool {
//        if vc.txtAmount.text?.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.AMOUNT.rawValue)
//            return false
//        } else if vc.txtAmount.text?.components(separatedBy: ".").count ?? 0 > 2 {
//            self.showMessage(message: Messages.AMOUNT_VALID.rawValue)
//            return false
//        } else if (vc.cardTextField.cardNumber?.trimmingCharacters(in: .whitespaces).count == 0) || (vc.cardTextField.cardNumber?.trimmingCharacters(in: .whitespaces).count == nil) {
//            self.showMessage(message: Messages.CARD_EMPTY.rawValue)
//            return false
//        } else  if vc.cardTextField.cardNumber?.trimmingCharacters(in: .whitespaces).count ?? 0 < 16 {
//            self.showMessage(message: Messages.CARD_LENGTH.rawValue)
//            return false
//        } else  if vc.cardTextField.expirationMonth == 0 ||  vc.cardTextField.expirationYear == 0 {
//            self.showMessage(message: Messages.EXPIRY_DATE.rawValue)
//            return false
//        } else  if vc.cardTextField.cvc!.trimmingCharacters(in: .whitespaces).count == 0 {
//            self.showMessage(message: Messages.CARD_CVV.rawValue)
//            return false
//        } else {
//            return true
//        }
//
//    }
}
}
