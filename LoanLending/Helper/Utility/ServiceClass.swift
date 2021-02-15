//
//  ServiceClass.swift
//  TradeInYourLease
//
//  Created by Ajay Vyas on 10/2/17.
//  Copyright © 2017 Ajay Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class ServiceClass: NSObject {

    static let sharedInstance = ServiceClass()
 
    enum ResponseType : Int {
        case   kResponseTypeFail = 0
        case  kresponseTypeSuccess
    }
    
    typealias completionBlockType = (ResponseType, JSON, AnyObject?) ->Void
    
    
    func hudShow()  {
           SVProgressHUD.setDefaultMaskType(.clear)
           SVProgressHUD.show()
       }
       func hudHide()  {
           SVProgressHUD.dismiss()
       }
    
    
  //MARK:- Common Get Webservice calling Method using SwiftyJSON and Alamofire
        func hitServiceWithUrlString( urlString:String, parameters:[String:AnyObject],headers:HTTPHeaders,completion:@escaping completionBlockType)
        {
            if Reachability.forInternetConnection()!.isReachable()
            {
                print(headers)
                print(urlString)
                print(parameters)
                hudShow()
                AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers : headers)
                    .responseJSON { response in
                        self.hudHide()
                        guard case .success(let rawJSON) = response.result else {
                            print("SomeThing wrong")
                            
                            var errorDict:[String:Any] = [String:Any]()
                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                            errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            return
                        }
                        if rawJSON is [String: Any] {
                            let json = JSON(rawJSON)
                            print(json)
                            
                            if  json["status"].intValue == 200 {
                                completion(ResponseType.kresponseTypeSuccess,json,nil)
                            }
                            else {
                                var errorDict:[String:Any] = [String:Any]()
                                errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                                errorDict[ServiceKeys.keyErrorDic] = json["errors"].dictionary
                                
                                print(json["error_code"].stringValue)
                                
                                if json["error_code"].stringValue == "delete_user"{
                                    SVProgressHUD.dismiss()
                                }
                                else {
                                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                }
                            }
                        }
                }
            }
            else {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let errorDict = NSMutableDictionary()
                    errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                    errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                }
                
            }
            
        }
        
        
        func hitServiceWithUrlStringWithErrorList( urlString:String, parameters:[String:AnyObject],headers:HTTPHeaders,completion:@escaping completionBlockType)
          {
              if Reachability.forInternetConnection()!.isReachable()
              {
                  print(headers)
                  print(urlString)
                  print(parameters)
                   hudShow()
                  AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers : headers)
                      .responseJSON { response in
                        self.hudHide()
                          guard case .success(let rawJSON) = response.result else {
                              print("SomeThing wrong")
                              
                              var errorDict:[String:Any] = [String:Any]()
                              errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                              errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                              completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                              return
                          }
                          if rawJSON is [String: Any] {
                              let json = JSON(rawJSON)
                              print(json)
                              if  json["status"] == true {
                                  completion(ResponseType.kresponseTypeSuccess,json,nil)
                              }
                              else {
                                  var errorDict:[String:Any] = [String:Any]()
                                  errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                  errorDict[ServiceKeys.keyErrorMessage] = json["message"].string
                                    errorDict[ServiceKeys.keyErrorDic] = json["errors"].dictionary
                                
                                  print(json["error_code"].dictionary)
                                   completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                  
                                  
                                  
                              }
                          }
                  }
              }
              else {
                  
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      let errorDict = NSMutableDictionary()
                      errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                      errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                      completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                  }
                  
              }
              
          }
        
        func hitGetServiceWithUrlString( urlString:String, parameters:[String:Any],headers:HTTPHeaders,completion:@escaping completionBlockType)
        {
            if Reachability.forInternetConnection()!.isReachable()
            {
//                            hudShow()
                let updatedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                let url = URL(string: updatedUrl!)!
                print("URL \(url)")
                print("PARAMETERS: \(parameters)")
                
            
                
                AF.request(url, method: .get , encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON { response in
                    
//                    self.hudHide()
                    guard case .success(let rawJSON) = response.result else {
                        print("SomeThing wrong")
                        
                        print(response.result)
                        
                        var errorDict:[String:Any] = [String:Any]()
                        errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                        errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                        
                        completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                        return
                    }
                    if rawJSON is [String: Any] {
                        
                        let json = JSON(rawJSON)
                        print(json)
                        if json["status"].intValue == 200 {
                            completion(ResponseType.kresponseTypeSuccess,json,nil)
                        }
                        else {
                            var errorDict:[String:Any] = [String:Any]()
                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                            errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                            print(json["error_code"].stringValue)
                            
                            
                            if json["error_code"].stringValue == "delete_user"{
                                SVProgressHUD.dismiss()
                                
                            }
                            else {
                                completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            }
                            
                            
                        }
                    }
             
                }
            }
                
            else  {
     
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let errorDict = NSMutableDictionary()
                    errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                    errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                }
            }
        }
        
        func hitGetServiceWithUrlParams( urlString:String, parameters:[String:Any],headers:HTTPHeaders,completion:@escaping completionBlockType)
           {
            
               if Reachability.forInternetConnection()!.isReachable()
               {
                   hudShow()
                   let updatedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                   let url = URL(string: updatedUrl!)!
                   print("URL \(url)")
                   print("PARAMETERS: \(parameters)")
                   
               
                   
                   AF.request(url, method: .get,parameters: parameters  , encoding: URLEncoding.default, headers: headers).responseJSON { response in
                       
                    self.hudHide()
                       guard case .success(let rawJSON) = response.result else {
                           print("SomeThing wrong")
                           
                           print(response.result)
                           
                           var errorDict:[String:Any] = [String:Any]()
                           errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                           errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong"
                           
                           completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                           return
                       }
                       if rawJSON is [String: Any] {
                           
                           let json = JSON(rawJSON)
                           print(json)
                           if  json["status"] == true {
                               completion(ResponseType.kresponseTypeSuccess,json,nil)
                           }
                           else {
                               var errorDict:[String:Any] = [String:Any]()
                               errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                               errorDict[ServiceKeys.keyErrorMessage] = json["message"].stringValue
                               print(json["error_code"].stringValue)
                               
                               
                               if json["error_code"].stringValue == "delete_user"{
                                   SVProgressHUD.dismiss()
                                   
                               }
                               else {
                                   completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                               }
                               
                               
                           }
                       }
                
                   }
               }
                   
               else  {
        
                   DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                       let errorDict = NSMutableDictionary()
                       errorDict.setObject(ErrorCodes.errorCodeInternetProblem, forKey: ServiceKeys.keyErrorCode as NSCopying)
                       errorDict.setObject("Check your internet connectivity", forKey: ServiceKeys.keyErrorMessage as NSCopying)
                       completion(ResponseType.kResponseTypeFail,JSON(),errorDict as NSDictionary)
                   }
               }
           }
        
    func imageUpload(_ urlString:String, params:[String : Any],data : Data?,doc:Data?,imageKey:String,fileName: String?,
        pathExtension: String?, headers:HTTPHeaders, completion:@escaping completionBlockType){
            
            print(urlString)
    //        print(params)
    //        AF.upload(multipartFormData:{ multipartFormData in
    ////            if let data1 = data {
    //            multipartFormData.append(data ?? Data() , withName: imageKey, fileName: "file.jpg", mimeType: "image/jpg")
    ////            }
                hudShow()
                                
                    AF.upload(multipartFormData: { multipartFormData in
    //                           if let data1 = data {
    //                            multipartFormData.append(data1 , withName:  imageKey, fileName: "attachment", mimeType: "image/jpg")
    //
                        if let data = doc {
                            multipartFormData.append(data, withName: "verificationId", fileName: "        .\(pathExtension!)", mimeType: "pdfDocuments.\(pathExtension!)")
                        }
                    
                        if let data = data {
                            multipartFormData.append(data, withName: "image", fileName: "\(fileName!).\(pathExtension!)", mimeType: "\(fileName!)/\(pathExtension!)")
                        }
                                   
    //                    multipartFormData.append(data ?? Data() , withName:  "identified", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                                    
                                    for (key, value) in params {
                                   
                                            let str = "\(value)"
                                            multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                                    }
                       }, to: urlString, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                           print("Upload Progress: \(progress.fractionCompleted)")
                       }).responseJSON(completionHandler: { data in
                           print("upload finished: \(data)")
                       }).response { (response) in
                        self.hudHide()
                        switch response.result {
                        case .success(let _):
                            
                                guard case .success(let rawJSON) = response.result else {
                                    var errorDict:[String:Any] = [String:Any]()
                                    errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                    errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong" + urlString
                                    
                                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                    
                                    return
                                }
                            
                                print(rawJSON ?? "")
                
                                if let rawJSN = rawJSON {
                                    let json = try? JSON(data: rawJSN)
                                   
                                    if  json?["success"] == false{
                                        
                                        let errorData = json?["errors"]
                                        for obj in json!["errors"].arrayValue {
                                            var errorDict:[String:Any] = [String:Any]()
                                            
                                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                            errorDict[ServiceKeys.keyErrorMessage] = obj["msg"].stringValue
                                            
                                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                            return
                                        }
//                                        print(errorData?["msg"].stringValue)
                                       
                                    }
                                    
                                    else {
                                        completion(ResponseType.kresponseTypeSuccess,json ?? JSON(),nil)
                                    }
                                
                            }
                        case .failure(let encodingError):
                            print(encodingError)
                        }
                    }

        }
    
    func SingleimageUpload(_ urlString:String, params:[String : Any],data : Data?,imageKey:String,fileName: String?,
        pathExtension: String?, headers:HTTPHeaders, completion:@escaping completionBlockType){
            
            print(urlString)
    //        print(params)
    //        AF.upload(multipartFormData:{ multipartFormData in
    ////            if let data1 = data {
    //            multipartFormData.append(data ?? Data() , withName: imageKey, fileName: "file.jpg", mimeType: "image/jpg")
    ////            }
                hudShow()
                                
                    AF.upload(multipartFormData: { multipartFormData in
    //                           if let data1 = data {
    //                            multipartFormData.append(data1 , withName:  imageKey, fileName: "attachment", mimeType: "image/jpg")
    //
                    
                    
                        if let data = data {
                            multipartFormData.append(data, withName: "image", fileName: "\(fileName!).\(pathExtension!)", mimeType: "\(fileName!)/\(pathExtension!)")
                        }
                                   
    //                    multipartFormData.append(data ?? Data() , withName:  "identified", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                                    
                                    for (key, value) in params {
                                   
                                            let str = "\(value)"
                                            multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                                    }
                       }, to: urlString, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                           print("Upload Progress: \(progress.fractionCompleted)")
                       }).responseJSON(completionHandler: { data in
                           print("upload finished: \(data)")
                       }).response { (response) in
                        self.hudHide()
                        switch response.result {
                        case .success(let _):
                            
                                guard case .success(let rawJSON) = response.result else {
                                    var errorDict:[String:Any] = [String:Any]()
                                    errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                    errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong" + urlString
                                    
                                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                    
                                    return
                                }
                            
                                print(rawJSON ?? "")
                
                                if let rawJSN = rawJSON {
                                    let json = try? JSON(data: rawJSN)
                                   
                                    if  json?["success"] == false{
                                        
                                        let errorData = json?["errors"]
                                        for obj in json!["errors"].arrayValue {
                                            var errorDict:[String:Any] = [String:Any]()
                                            
                                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                            errorDict[ServiceKeys.keyErrorMessage] = obj["msg"].stringValue
                                            
                                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                            return
                                        }
//                                        print(errorData?["msg"].stringValue)
                                       
                                    }
                                    
                                    else {
                                        completion(ResponseType.kresponseTypeSuccess,json ?? JSON(),nil)
                                    }
                                
                            }
                        case .failure(let encodingError):
                            print(encodingError)
                        }
                    }

        }
        
    func SingleDocimageUpload(_ urlString:String, params:[String : Any],doc:Data?,imageKey:String,fileName: String?,
        pathExtension: String?, headers:HTTPHeaders, completion:@escaping completionBlockType){
            
            print(urlString)
    //        print(params)
    //        AF.upload(multipartFormData:{ multipartFormData in
    ////            if let data1 = data {
    //            multipartFormData.append(data ?? Data() , withName: imageKey, fileName: "file.jpg", mimeType: "image/jpg")
    ////            }
                hudShow()
                                
                    AF.upload(multipartFormData: { multipartFormData in
    //                           if let data1 = data {
    //                            multipartFormData.append(data1 , withName:  imageKey, fileName: "attachment", mimeType: "image/jpg")
    //
                        if let data = doc {
                            multipartFormData.append(data, withName: "paySlips", fileName: "pdfDocuments.\(pathExtension!)", mimeType: "pdfDocuments.\(pathExtension!)")
                        }
                    
                       
                                   
    //                    multipartFormData.append(data ?? Data() , withName:  "identified", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                                    
                                    for (key, value) in params {
                                   
                                            let str = "\(value)"
                                            multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                                    }
                       }, to: urlString, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                           print("Upload Progress: \(progress.fractionCompleted)")
                       }).responseJSON(completionHandler: { data in
                           print("upload finished: \(data)")
                       }).response { (response) in
                        self.hudHide()
                        switch response.result {
                        case .success(let _):
                            
                                guard case .success(let rawJSON) = response.result else {
                                    var errorDict:[String:Any] = [String:Any]()
                                    errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                    errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong" + urlString
                                    
                                    completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                    
                                    return
                                }
                            
                                print(rawJSON ?? "")
                
                                if let rawJSN = rawJSON {
                                    let json = try? JSON(data: rawJSN)
                                   
                                    if  json?["success"] == false{
                                        
                                        let errorData = json?["errors"]
                                        for obj in json!["errors"].arrayValue {
                                            var errorDict:[String:Any] = [String:Any]()
                                            
                                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                            errorDict[ServiceKeys.keyErrorMessage] = obj["msg"].stringValue
                                            
                                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                                            return
                                        }
//                                        print(errorData?["msg"].stringValue)
                                       
                                    }
                                    
                                    else {
                                        completion(ResponseType.kresponseTypeSuccess,json ?? JSON(),nil)
                                    }
                                
                            }
                        case .failure(let encodingError):
                            print(encodingError)
                        }
                    }

        }
        
        
        //multiple images upload
        func multipleImageUpload(_ urlString:String, params:[String : Any],data: [Data],identifiedImageData : Data,headers:HTTPHeaders, completion:@escaping completionBlockType){
             
             print(urlString)
             print(params)
             print(data)
            
            hudShow()
            AF.upload(multipartFormData: { multipartFormData in
                      for imgData in data {
                                          multipartFormData.append(imgData , withName:  "file_data[]", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                                      }
                           
                            multipartFormData.append(identifiedImageData , withName:  "identified", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                            
                            for (key, value) in params {
                           
                                    let str = "\(value)"
                                    multipartFormData.append(((str as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                            }
               }, to: urlString, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
                   print("Upload Progress: \(progress.fractionCompleted)")
               }).responseJSON(completionHandler: { data in
                   print("upload finished: \(data)")
               }).response { (response) in
                self.hudHide()
                switch response.result {
                case .success(let _):
                    
                        guard case .success(let rawJSON) = response.result else {
                            var errorDict:[String:Any] = [String:Any]()
                            errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                            errorDict[ServiceKeys.keyErrorMessage] = "SomeThing wrong" + urlString
                            
                            completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            
                            return
                        }
                        print(rawJSON ?? "")
        
                        if let rawJSN = rawJSON {
                            let json = try? JSON(data: rawJSN)
                            
                            if  json?["status"] == "error"{
                                var errorDict:[String:Any] = [String:Any]()
                                
                                errorDict[ServiceKeys.keyErrorCode] = ErrorCodes.errorCodeFailed
                                errorDict[ServiceKeys.keyErrorMessage] = json?["message"].stringValue
                                
                                completion(ResponseType.kResponseTypeFail,JSON(),errorDict as AnyObject);
                            }
                            else {
                                completion(ResponseType.kresponseTypeSuccess,json ?? JSON(),nil)
                            }
                        
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }

             
         }
     
       //MARK:- EmailLogin
     
  
    
    //MARK:- OTPLogin
     func hitServiceForOTPVerify(_ params:[String : Any], completion:@escaping completionBlockType)
     {
         let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.verify_OTP)"
        
         let headers: HTTPHeaders = ["os" : OS,"version":ios_version]
         self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
     }
    
    //MARK:- OTP Send
    func hitServiceForOTPSend(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.send_OTP)"
           
             let headers: HTTPHeaders = ["accept": "application/json","Content-Type": "application/json"]
            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    
    func hitServiceForCountryCode(_ params:[String : Any], completion:@escaping completionBlockType)
        {
            let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.appData)"
            let headers: HTTPHeaders = ["accept": "application/json","Content-Type": "application/json","os" : OS,"version":ios_version]
            self.hitGetServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
        }
    
    // For SignUp
    func hitServiceForRegistration(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.enterregistrationcode)"
        print(baseUrl)
           let headers: HTTPHeaders = [ "Content-Type" : "application/json","os" : OS,"version":ios_version]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    func hitServiceForlogin(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.login)"
        let headers: HTTPHeaders = [ "Content-Type" : "application/json","os" : OS,"version":ios_version]
       
        self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    func hitServiceForForgotPassword(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.forgot_password)"
        print(baseUrl)
        let headers: HTTPHeaders = [:]
        print_debug(params)
        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
    
   func hitServiceForUpdatePassword(_ params:[String : Any], completion:@escaping completionBlockType)
    {
//        let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.change_password)"
//        print(baseUrl)
//        let headers: HTTPHeaders = ["Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
//        self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
    }
    
//    func hitServiceForLogOut(_ params:[String : Any], completion:@escaping completionBlockType)
//               {
//                   let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.logout)"
//                   print(baseUrl)
//                   let headers: HTTPHeaders = ["Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
//                   print_debug(params)
//                   self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
//               }
    
    func hitServiceForResetPassword(_ params:[String : Any], completion:@escaping completionBlockType)
         {
             let baseUrl = "\(ServiceUrls.baseUrl)\(ServiceUrls.setPasswordForgot)"
             print(baseUrl)
             let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
             print_debug(params)
             self.hitServiceWithUrlString(urlString: baseUrl, parameters: params as [String : AnyObject] , headers: headers, completion: completion)
         }
    
   
    
   


    //MARK:- Register
   
   
    
    //MARK:- Register_new
   
    
    //MARK:- Get languages
   
     
    
    //    //MARK : Submit Lang
 
    
    
    
     //MARK:- Get Country
    
      
    
    //MARK:- Get category
       
        
    
     
     //    //MARK : Submit Country
   
    
    
    
   
    
  
    
    
    
    
    func hitServiceForHomeLoan(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.loan_Types)"
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
        self.hitGetServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
    }
    func hitServiceForHomeLoanData(_ params:[String : Any],loanType:String?, completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.loan_lender)?loan_type=\(loanType ?? "")"
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
        self.hitGetServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
    }
    func hitServiceForMyLoanData(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.my_loan_list)"
        let headers: HTTPHeaders = ["os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
        self.hitGetServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
    }
    func hitServiceForMyUserData(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.my_User_Data)"
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
        self.hitGetServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
    }
    
    func hitServiceFoHisstoryData(_ params:[String : Any], completion:@escaping completionBlockType)
    {
        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.my_History)"
        let headers: HTTPHeaders = [ "os" : OS,"version":ios_version, "Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token)]
        self.hitGetServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
    }
    //MARK:- Product Like
    
   
         
    
    
    //MARK:- language fetch API Call
       
    
 
    
    
    
    
    

    
  
   
    
   
    
    
   
   
  
    
    
   
 
    
    
    //MARK:- PROFILE UPDATE AND VIEW
    
   
    
    func hitServiceFor_SocialLogin(_ params:[String : Any],data: Data,document:Data,imageKey:String="image", completion:@escaping completionBlockType)
          {
              let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.regiser_New_User)"
             
              let headers: HTTPHeaders = [ "Content-Type" : "multipart/form-data","accept": "application/json" ]
//               self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
            
        self.imageUpload(urlString, params: params as [String : AnyObject], data: data, doc: document, imageKey: imageKey, fileName: imageKey, pathExtension: ".jpg", headers: headers, completion: completion)
          }
    
    
    func hitServiceFor_UpdateProfile(_ params:[String : Any],data: Data,imageKey:String="image", completion:@escaping completionBlockType)
          {
              let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.update_User_Profile)"
             
              let headers: HTTPHeaders = ["accept": "application/json","Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token), "os" : "IOS","version":"1" ]
//               self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
            
        self.SingleimageUpload(urlString, params: params as [String : AnyObject], data: data, imageKey: imageKey, fileName: imageKey, pathExtension: ".jpg", headers: headers, completion: completion)
          }
    
    
    func hitServiceFor_SubmitLoanRequest(_ params:[String : Any],document:Data,imageKey:String="image", completion:@escaping completionBlockType)
          {
              let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.loan_Request)"
             
              let headers: HTTPHeaders = ["accept": "application/json","Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token), "os" : "IOS","version":"1" ]
//               self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
            
        self.SingleDocimageUpload(urlString, params: params as [String : AnyObject], doc: document, imageKey: imageKey, fileName: imageKey, pathExtension: ".jpg", headers: headers, completion: completion)
          }
    
    func hitServiceForcheckMobileREgistered(_ params:[String : Any], completion:@escaping completionBlockType)
          {
              let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.check_Mobile_Registered)"
             
              let headers: HTTPHeaders = [ "Content-Type" : "application/json", "accept": "application/json",]
              
               self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
          }
    
    func hitServiceForupdate_Passowrd(_ params:[String : Any], completion:@escaping completionBlockType)
          {
              let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.upate_Password)"
             
              let headers: HTTPHeaders = [ "Content-Type" : "application/json", "accept": "application/json","Authorization": "Bearer " + AppHelper.getStringForKey(ServiceKeys.token), "os" : "IOS","version":"1"]
              
               self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
          }
    func hitServiceForNewe_Passowrd(_ params:[String : Any], completion:@escaping completionBlockType)
          {
              let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.forgot_Password)"
             
              let headers: HTTPHeaders = [ "Content-Type" : "application/json", "accept": "application/json", "os" : "IOS","version":"1"]
              
               self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
          }
    
    
    
    //MARK:- FOllowing and Follower APi call
    
    
 
    
   
    
    
   
    
    
   
 
//    
//     
//     //MARK:- Get all board list
//    
//       func hitServiceForGetAllBoard(_ params:[String : Any], completion:@escaping completionBlockType)
//       {
//           let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.board_list)"
//          
//           let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
//           self.hitGetServiceWithUrlParams(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//       }
//   
//    //MARK:- Get all sub list
//      
//         func hitServiceForGetAllSubjects(_ params:[String : Any], completion:@escaping completionBlockType)
//         {
//             let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.subject_list)"
//            
//             let headers: HTTPHeaders = [ "Content-Type" : "application/json"]
//             self.hitGetServiceWithUrlParams(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//         }
//    

//    
//    //MARK : Get Tutor Details
//       func hitServiceForGetTutorDetail(_ params:[String : Any], completion:@escaping completionBlockType)
//       {
//           let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.tutor_profile)"
//           let headers: HTTPHeaders = [ "Content-Type" : "application/json", "access_token": AppHelper.getStringForKey(ServiceKeys.token)]
//        self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//       }
//    
//    //MARK : Submit Message
//       func hitServiceForSubmitMessage(_ params:[String : Any], completion:@escaping completionBlockType)
//       {
//           let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.tutor_send_message)"
//        let headers: HTTPHeaders = [ "Content-Type" : "application/json", "Authorization" : "bearer " + AppHelper.getStringForKey(ServiceKeys.token) ]
//        self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//       }
//    
//    
//    //MARK : Follow API
//          func hitServiceForCreateFollower(_ params:[String : Any], completion:@escaping completionBlockType)
//          {
//              let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.create_follower)"
//           let headers: HTTPHeaders = [ "Content-Type" : "application/json", "Authorization" : "bearer " + AppHelper.getStringForKey(ServiceKeys.token) ]
//           self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//          }
//    
//    //MARK : Submit Rate
//         func hitServiceForSubmitRating(_ params:[String : Any], completion:@escaping completionBlockType)
//         {
//             let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.tutor_rating_by_student)"
//          let headers: HTTPHeaders = [ "Content-Type" : "application/json", "Authorization" : "bearer " + AppHelper.getStringForKey(ServiceKeys.token) ]
//          self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//         }
// 
//    //MARK : Join API
//           func hitServiceForJoin(_ params:[String : Any], completion:@escaping completionBlockType)
//           {
//               let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.create_follower)"
//            let headers: HTTPHeaders = [ "Content-Type" : "application/json", "Authorization" : "bearer " + AppHelper.getStringForKey(ServiceKeys.token) ]
//            self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//           }
//    
//    //MARK : Get search
//       func hitServiceForSearchQueries(_ params:[String : Any], completion:@escaping completionBlockType)
//       {
//           let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.search_string)"
//           let headers: HTTPHeaders = [ "Content-Type" : "application/json", "access_token": AppHelper.getStringForKey(ServiceKeys.token)]
//           self.hitGetServiceWithUrlParams(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//       }
//    
// 
//  
//    //MARK : Get All Notification
//      func hitServiceForGetAllTutorVideos(_ params:[String : Any], completion:@escaping completionBlockType)
//      {
//          let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.tutor_profile_videos)"
//          let headers: HTTPHeaders = [ "Content-Type" : "application/json", "access_token": AppHelper.getStringForKey(ServiceKeys.token)]
//       self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//      }
//
//    
//    //MARK : Get Community Detail
//     func hitServiceForGetAllCommunityDetail(_ params:[String : Any], completion:@escaping completionBlockType)
//     {
//         let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.get_query_detail)"
//         let headers: HTTPHeaders = [ "Content-Type" : "application/json", "access_token": AppHelper.getStringForKey(ServiceKeys.token)]
//        self.hitGetServiceWithUrlParams(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//     }
//    
// 
//    //MARK : Create Request
//    func hitServiceForReviewRateList(_ params:[String : Any], completion:@escaping completionBlockType)
//    {
//        let urlString = "\(ServiceUrls.baseUrl)\(ServiceUrls.tutor_review_list)"
//        let headers: HTTPHeaders = [ "Content-Type" : "application/json", "access_token": AppHelper.getStringForKey(ServiceKeys.token)]
//        self.hitServiceWithUrlString(urlString: urlString, parameters: params as [String : AnyObject], headers: headers, completion: completion)
//    }
//
//    
    
    //MARK :  Post upload ans
   

    

           
    
  
    
    
    
   
    
    
      //MARK : Get AllCommunity
}
