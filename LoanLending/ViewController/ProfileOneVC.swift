//
//  ProfileOneVC.swift
//  Union
//
//  Created by Ravi on 15/05/20.
//  Copyright © 2020 Union. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
let reuseIdentifier = "btnCell"
class ProfileOneVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate{
    
    @IBOutlet weak var userNameLocLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
   
    @IBOutlet weak var heightFeetView: UIView!
   
    @IBOutlet weak var btnPickImage: UIButton!
  
    var imageData = Data()
    @IBOutlet weak var btnSave: UIButton!
   
    @IBOutlet weak var staffIDTxtFld: UITextField!
    @IBOutlet weak var txtMbl: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var femaleImageView: UIImageView!
    @IBOutlet weak var maleImageView: UIImageView!
    var isMaleButtonSelected: Bool = true {
        didSet {
            if isMaleButtonSelected {
                self.gender = "male"
                self.femaleImageView.image = #imageLiteral(resourceName: "icons8-circle-32")
                self.maleImageView.image = #imageLiteral(resourceName: "check@1")

            } else {
                self.gender = "female"
                self.femaleImageView.image = #imageLiteral(resourceName: "check@1")
                self.maleImageView.image = #imageLiteral(resourceName: "icons8-circle-32")
            }
        }
    }
   
   
    var interested_in : String = "1"
    var gender : String = "Male"
    var bodytype : String = ""
    var height_type : String = "Feet"
    var height_body : String = ""
    var dob : String  = ""
    let datePicker = UIDatePicker()
    var pickerView: UIPickerView! = UIPickerView()
    var pickerViewCm: UIPickerView! = UIPickerView()
    var feetvalue : String = ""
    var inch : String = ""
    var isedit : Bool = false
    var pickerData: [[String]] = [[String]]()
    var pickerData2: Array<String> = []
    var user = User(){
        didSet {
            dataSetup()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
       
       
        // Input the data into the array
      
      
        
        self.viewTextStep()
       // self.setupTYHeightPicker()
        self.dataSetup()
        myUserData()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func backButtonACtion(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func dataSetup() {
        
        self.txtUsername.text = self.user.email
        self.txtMbl.text = self.user.mobile
        self.txtFullName.text = self.user.name
        self.txtCompanyName.text = self.user.company
        self.txtCity.text = self.user.city
        self.txtUsername.isUserInteractionEnabled = false
        self.txtMbl.isUserInteractionEnabled = false
        self.staffIDTxtFld.text = self.user.staffId
        if self.user.gender == "male" {
            self.gender = "male"
            self.isMaleButtonSelected = true
            
        }
        else {
            self.gender = "female"
            self.isMaleButtonSelected = false
        }
        if let imageStr = user.image{
            print(imageStr)
           
            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
                userImageView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "ino-image"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
        }
        
      //  heighPicker.setDefaultHeight(6.4, unit: .Inch)

    @IBAction func btnPickAction(_ sender: Any) {
        setImageForComplaint(imageSec: "1")
    }
    @IBAction func femaleBtnAction(_ sender: Any) {
        isMaleButtonSelected = false
    }
    
    @IBAction func maleBtnAction(_ sender: Any) {
        isMaleButtonSelected = true
        
    }
    
  
   
    
    
 
   
    
    @IBAction func actionSave(_ sender: Any) {
        update_Profile()
   
    }
    
  
    func viewTextStep(){
        
        
        txtUsername.setLeftPaddingPoints(8)
        txtMbl.setLeftPaddingPoints(8)

       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // self.navigationItem.titleView = self.tabbarTitleView(title:"Login",color:AppFontColor)
        //  self.navigationController?.setNavigationBarHidden(true, animated: true)
        //              self.navigationItem.leftBarButtonItem = self.tabbarCustomItem(imgName: "back_btn", imgColor:AppColor, action: #selector(actionBack(_:)))
        //
//        let imageDataDict:[String: Int] = ["view": 1]
//        
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveProfile"), object: nil, userInfo: imageDataDict)
    }
    
    
    // MARK : - API call
    func callAPIforFirstProfile() {
        
        
        
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
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           
           
              
                self.userImageView.image = pickedImage
               
               
            
            let imageData = pickedImage.jpegData(compressionQuality: 0.1)! as Data
        print(imageData)
            self.imageData = imageData
        picker.dismiss(animated: true, completion: nil)
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
    // MARK: - delegate PickerView
    func myUserData(){
        let params =  [String : Any]()
     
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceForMyUserData(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let userDatas = parseData["data"]
             
                    self.user = User(fromJson:userDatas)
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
    func update_Profile(){
        var params =  [String : Any]()
        params["email"] = self.txtUsername.text ?? ""
        params["name"] = self.txtFullName.text ?? ""
        params["language"] = self.user.language
        params["country_code"] = self.user.country_code
        params["staffId"] = self.staffIDTxtFld.text
        params["company"]  = self.txtCompanyName.text ?? ""
      
        params["city"] = self.txtCity.text ?? ""
         params["gender"] = self.gender
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceFor_UpdateProfile(params, data: imageData, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let message = parseData["message"].stringValue
                Common.showAlert(alertMessage: message, alertButtons: ["Ok"]) { (bt) in
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
    
}
