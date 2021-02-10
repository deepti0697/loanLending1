//
//  SignUpThirdVC.swift
//  LoanLending
//
//  Created by deepti on 13/01/21.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import SwiftyJSON
class SignUpThirdVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate {
    
    
    @IBOutlet weak var remeberMeImageView: UIImageView!
    @IBOutlet weak var alreadyHaveAnAccountLbl: UILabel!
    @IBOutlet weak var loginBtm: UIButton!
    @IBOutlet weak var acceptTCLbl: UILabel!
    @IBOutlet weak var uploadImageBtn: UIButton!
    @IBOutlet weak var uploadDocBtn: UIButton!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var termAndCondtionLbl: UIButton!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var acceptLbl: UIButton!
    @IBOutlet weak var uploadImageLbl: UILabel!
    @IBOutlet weak var uploadIdLbl: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var emailIDLbl: UILabel!
   
    var isAcceptTermCondition = false
    var imageData = Data()
    var staffID:String?
    var fullName:String?
    var gender:String?
    var companyName:String?
    var city:String?
    var mobile:String?
    var password:String?
    var document = Data()
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    var isDocImageView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalized()
        self.emailTxt.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func setUP(){
       

    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    func setupLocalized()
    {
        self.signUpLbl.text = ("signup".localized(lang))
        self.emailIDLbl.text = ("emailID".localized(lang))
        self.uploadIdLbl.text = ("uploadID".localized(lang))
        self.uploadImageLbl.text = ("uploadImage".localized(lang))
        self.nextBtn.setTitle("next".localized(lang), for: .normal)
        self.uploadDocBtn.setTitle("uploadDocs".localized(lang), for: .normal)
        self.emailTxt.placeholder = ("enterEmail".localized(lang))
        self.acceptTCLbl.text = ("iAccept".localized(lang))
        self.acceptLbl.setTitle("termAcondition".localized(lang), for: .normal)
        self.alreadyHaveAnAccountLbl.text = ("alreadyHaveAccnt".localized(lang))
        self.uploadDocBtn.setTitle("uploadDocs".localized(lang), for: .normal)
        self.uploadImageBtn.setTitle("uploadImage".localized(lang), for: .normal)
        self.loginBtm.setTitle("login".localized(lang), for: .normal)
    }

    @IBAction func uploadImageBtn(_ sender: Any) {
    }
    @IBAction func uploadDocAction(_ sender: Any) {
 let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
        //Call Delegate
        documentPicker.delegate = self
        self.present(documentPicker, animated: true)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
//        let pdfData = try! Data(contentsOf:urls)
//                           var data : Data = pdfDat
        guard let myURL = urls.first else {
               return
           }
           print("import result : \(myURL)")
        let path:String = myURL.path
        self.document = try! Data(contentsOf:myURL)
//        self.uploadDocBtn.setTitle("", for: .normal)
//        self.uploadDocBtn.setImage(UIImage(named: ""), for: .normal)
        self.docImageView.image = drawPDFfromURL(url: myURL)
        self.docImageView.image = UIImage().imagetAccodingToExtension(extensionStr: path)
    }
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }

        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(page)
        }

        return img
    }

    @IBAction func uploadImageAC(_ sender: Any) {
        isDocImageView = false
        setImageForComplaint(imageSec: "")
    
    }
    
    @IBAction func remeberMeAction(_ sender: UIButton) {
        if sender.isSelected {
            isAcceptTermCondition = false
            self.remeberMeImageView.image = #imageLiteral(resourceName: "uncheck")
        }
        else {
            isAcceptTermCondition = true
            self.remeberMeImageView.image = #imageLiteral(resourceName: "check")
        }
        sender.isSelected = !sender.isSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           
            if isDocImageView {
               
                self.docImageView.image = pickedImage
            }
            else {
              
                self.uploadImageView.image = pickedImage
               
               
            }
            let imageData = pickedImage.jpegData(compressionQuality: 0.1)! as Data
        print(imageData)
            self.imageData = imageData
        picker.dismiss(animated: true, completion: nil)
    }
    }
    fileprivate func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning".localized(lang), message: "You don't have permission to access gallery".localized(lang), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func openVerificaatnVc(_ sender: Any) {
        if Validate.shared.validateLogin(vc: self) {
         
        var params =  [String : Any]()
        params["email"] = self.emailTxt.text ?? ""
        params["name"] = self.fullName
        params["language"] = AppHelper.getStringForKey(ServiceKeys.languageType)
        params["country_code"] = "91"
        params["staffId"] = self.staffID
        params["mobile"]  = self.mobile
        params["company"] = self.companyName
        params["city"] = self.city
        params["password"] = self.password
        params["gender"] = self.gender
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceFor_SocialLogin(params, data: imageData, document: document, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                if parseData["status"].intValue == 400 {
                    Common.showAlert(alertMessage: parseData["message"].stringValue, alertButtons: ["Ok"]) { (bt) in
                    }
                }
                else {
                Common.showAlert(alertMessage: parseData["message"].stringValue, alertButtons: ["Ok"]) { (btn) in
                    self.openViewController(controller: OTPVerificationVC.self, storyBoard: .mainStoryBoard, handler: { (vc) in
                        vc.phonenumber = self.mobile ?? ""
                        vc.type = "login"
                    })
                }
                }
            } else {
                
                guard let dicErr = errorDict?["msg"] as? String else {
                    return
                }
                Common.showAlert(alertMessage: (dicErr), alertButtons: ["Ok"]) { (bt) in
                }
                
                
            }
        })
        }
        

    }
    fileprivate func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func setImageForComplaint(imageSec:String) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func loginButtonAction(_ sender: Any) {
                openViewController(controller: LoginViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
            })
    }
    
  
}



extension SignUpThirdVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTxt {
         
            textField.resignFirstResponder()
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
