//
//  LoanRequestViewController.swift
//  LoanLending
//
//  Created by deepti on 19/01/21.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import SwiftyJSON
import ActionSheetPicker_3_0
class LoanRequestViewController: UIViewController,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var lbl_LoanAmount = UIButton()
    var lbl_Tenure = UIButton()
    var loanAmount = 50000
    var isAcceptTermCondition = true
    var tenure = 1
    var totalEMI = 0.0
    var totalPayment = 0.0
    var initalValue = 0
    var walletType  = ["Bank","Cash","Cheque"]
    @IBOutlet weak var termAndCondtionLbl: UIButton!
    @IBOutlet weak var iAcceptLbl: UILabel!
    @IBOutlet weak var nextBtnOutlt: UIButton!
    @IBOutlet weak var selectMobileWalletTxt: UITextField!
    @IBOutlet weak var bankNameTxtFld: UITextField!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var emiLbl: UILabel!
    @IBOutlet weak var interestAmountLocLbl: UILabel!
    @IBOutlet weak var clcEMILocLbl: UILabel!
    @IBOutlet weak var maximumMotnhSliderLbl: UILabel!
    @IBOutlet weak var minimumMotnhsSliderLbl: UILabel!
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var purposeOfLoanTxxtfld: UITextField!
    @IBOutlet weak var purposeOfLoanLocLbl: UILabel!
    @IBOutlet weak var TotalTimeLocLbl: UILabel!
    @IBOutlet weak var loanReqLocLbl: UILabel!
    @IBOutlet weak var loanAmountSlider: UISlider!
    @IBOutlet weak var tenureSlider: UISlider!
    
    @IBOutlet weak var uploadDocBtn: UIButton!
    var document = Data()
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setUP()
    }
    var loaninfo:LoanList?
   
    func setUP(){
        lbl_LoanAmount.layer.cornerRadius = 5
        lbl_Tenure.layer.cornerRadius = 5
        
        
        lbl_LoanAmount.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_LoanAmount.frame = CGRect(x: 0,y: 32,width: 100,height: 25)
        
        lbl_LoanAmount.setTitleColor(.white, for: .normal)
//        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_LoanAmount.setTitle("0", for: .normal)
        lbl_LoanAmount.center = setUISliderThumbValueWithLabel(slider: loanAmountSlider.self)
        loanAmountSlider.addSubview(lbl_LoanAmount)
        lbl_LoanAmount.isHidden = true
        lbl_Tenure.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_Tenure.frame = CGRect(x: 0,y: 32,width: 100,height: 25)
        lbl_Tenure.setTitleColor(.white, for: .normal)
//        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_Tenure.setTitle("0" + " Months", for: .normal)
        lbl_Tenure.center = setUISliderThumbValueWithLabel(slider: tenureSlider.self)
        tenureSlider.addSubview(lbl_Tenure)
        lbl_Tenure.isHidden = true
        self.minimumMotnhsSliderLbl.text = "\(self.loaninfo?.min_tenure ?? "") Months"
        self.maximumMotnhSliderLbl.text = "\(self.loaninfo?.max_tenure ?? "") Months"
        self.tenureSlider.minimumValue = Float(self.loaninfo?.min_tenure ?? "") ?? 0.0
        self.tenureSlider.maximumValue = Float(self.loaninfo?.max_tenure ?? "") ?? 0.0
    }
    @IBAction func oWallet(_ sender: Any) {
    showTimeSheet(textField: selectMobileWalletTxt)
    }
    
    func showTimeSheet(textField : UITextField){
        let array = self.walletType
        let placeHolder = "List"
        let customStringPicker = ActionSheetStringPicker.init(title:placeHolder, rows: array as [Any], initialSelection:initalValue, doneBlock:
        { picker, values, indexes in
            textField.text = (String(describing: indexes!))
            self.initalValue = values
            return
        }, cancel: nil, origin: textField)
        customStringPicker!.tapDismissAction = TapAction.cancel
        self.view.endEditing(true)
        customStringPicker!.show()
    }
    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
        let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 16, y: slider.frame.origin.y - 30)
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
        self.uploadDocBtn.setTitle("", for: .normal)
        self.uploadDocBtn.setImage(UIImage(named: ""), for: .normal)
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
    @IBAction func uploadDocAction(_ sender: Any) {
       let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
        //Call Delegate
        documentPicker.delegate = self
        self.present(documentPicker, animated: true)
    }
    @IBAction func tenureSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        print(currentValue)
        self.lbl_Tenure.isHidden = false
        let x = Int(round(sender.value))
        lbl_Tenure.setTitle("\(x)" + " Months", for: .normal)
        self.tenure = (x)
        lbl_Tenure.center = setUISliderThumbValueWithLabel(slider: sender)
        setupEMI()
    }
    @IBAction func distancesSliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        print(currentValue)
        self.lbl_LoanAmount.isHidden = false
        let x = Int(round(sender.value))
        lbl_LoanAmount.setTitle("\(x)", for: .normal)
        self.loanAmount = (x)
        lbl_LoanAmount.center = setUISliderThumbValueWithLabel(slider: sender)
        setupEMI()

    }
    func calculateEmi(loanAmount : Double, loanTenure : Double, interestRate : Double)  {
        let interestRateVal = interestRate / 1200
        let loanTenureVal = loanTenure * 12
        self.totalEMI = Double(loanAmount * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal))))
        self.emiLbl.text =  String(format: "%.2f",loanAmount * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal))))
    }
    func setupEMI(){
        calculateEmi(loanAmount: Double(loanAmount), loanTenure: Double(tenure), interestRate: Double(self.loaninfo?.interest ?? "") ?? 0.0)
        calculateTotalPayment(Double(totalEMI), loanTenure: (tenure))
      
    }
    func calculateTotalPayment(_ emi : Double, loanTenure : NSInteger)  {
        let totalMonth = loanTenure * 12
        self.totalAmount.text = String(format: "%.2f",emi * Double(totalMonth))
        self.totalPayment = emi * Double(totalMonth)
    }
    
   
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        submitLoanRequest()
    }
    func submitLoanRequest()
    {
        if Validate.shared.validateSubmitLoanPage(vc: self) {
         
        var params =  [String : Any]()
            params["lender"] = self.loaninfo?.id
            params["loan_type"] = self.loaninfo?.loanTypes[0].id
            params["purpose"] = self.purposeOfLoanTxxtfld.text ?? ""
            params["amount"] = self.loanAmount
            params["tenure"] = self.tenure
            params["interest"]  = self.loaninfo?.interest
            params["processingFee"] = self.loaninfo?.processingFee
        params["emi"] = self.totalEMI
            params["bankAccount"] = self.bankNameTxtFld.text
            params["wallet"] = self.selectMobileWalletTxt.text
        AppManager.init().hudShow()
        ServiceClass.sharedInstance.hitServiceFor_SubmitLoanRequest(params, document: document, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
            print_debug("response: \(parseData)")
            AppManager.init().hudHide()
            if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                let message = parseData["message"].stringValue
                Common.showAlert(alertMessage: message, alertButtons: ["Ok"]) { (bt) in
                    self.navigationController?.popViewController(animated: true)
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
}
