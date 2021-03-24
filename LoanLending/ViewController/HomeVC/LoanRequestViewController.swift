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
    
    var lenderID:String?
    
    var lbl_LoanAmount = UIButton()
    var lbl_Tenure = UIButton()
    var loanAmount = 50000
    var isAcceptTermCondition = false
    var tenure = 1
    var totalEMI = 0.0
    var totalPayment = 0.0
    var initalValue = 0
    var intialLoanValue = 0
    var walletType  = ["Bank Transfer","Cheque","Mobile Money Wallet"]
    var loanPurpose  = [PurposeMarrige]()
    var rangeMinimumValue:String?
    var rangeMaximumValue:String?
    @IBOutlet weak var termAndCondtionLbl: UIButton!
    @IBOutlet weak var upload3MonthPaySlip: UILabel!
    @IBOutlet weak var selectMobileWalletLocLbl: UILabel!
    @IBOutlet weak var iAcceptLbl: UILabel!
    @IBOutlet weak var nextBtnOutlt: UIButton!
    @IBOutlet weak var selectMobileWalletTxt: UITextField!
    
    @IBOutlet weak var maximumLbl: UILabel!
    @IBOutlet weak var minimumLbl: UILabel!
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
    
    @IBOutlet weak var acceptImageView: UIImageView!
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
    var loaninfo:LoanType?
    
    func setUP(){
        lbl_LoanAmount.layer.cornerRadius = 5
        lbl_Tenure.layer.cornerRadius = 5
        
        lbl_LoanAmount.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_LoanAmount.frame = CGRect(x: 0,y: 32,width: 80,height: 25)
        
        lbl_LoanAmount.setTitleColor(.white, for: .normal)
        //        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_LoanAmount.setTitle("₵0", for: .normal)
        lbl_LoanAmount.center = setUISliderThumbValueWithLabel(slider: loanAmountSlider.self)
        loanAmountSlider.addSubview(lbl_LoanAmount)
        lbl_LoanAmount.isHidden = true
        lbl_Tenure.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_Tenure.frame = CGRect(x: 0,y: 32,width: 95,height: 25)
        lbl_Tenure.setTitleColor(.white, for: .normal)
        //        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_Tenure.setTitle("1" + " Months", for: .normal)
        lbl_Tenure.center = setUISliderThumbValueWithLabel(slider: tenureSlider.self)
        tenureSlider.addSubview(lbl_Tenure)
        lbl_Tenure.isHidden = true
        self.minimumMotnhsSliderLbl.text = "\(self.loaninfo?.min_tenure ?? "") Months"
        self.tenureSlider.value = Float(self.loaninfo?.min_tenure ?? "") ?? 0.0
        self.maximumMotnhSliderLbl.text = "\(self.loaninfo?.max_tenure ?? "") Months"
        self.tenureSlider.minimumValue = Float(self.loaninfo?.min_tenure ?? "") ?? 0.0
        self.tenureSlider.maximumValue = Float(self.loaninfo?.max_tenure ?? "") ?? 0.0
        if let loaninfos = loaninfo?.min_amount {
            self.loanAmountSlider.minimumValue = Float(loaninfos) ?? 0.0
            self.minimumLbl.text = loaninfos
            self.loanAmountSlider.value = Float(loaninfos) ?? 0.0
        }
        if let loaninfos = loaninfo?.max_amount {
            self.loanAmountSlider.maximumValue = Float(loaninfos) ??  0.0
            self.maximumLbl.text = loaninfos
        }
    }
    
    func localizableSetup(){
        loanReqLocLbl.text = "Request for a Loan".localized(lang)
        TotalTimeLocLbl.text = "How much do you want to borrow and for how long".localized(lang)
        
        purposeOfLoanLocLbl.text = "Purpose for loan".localized(lang)
        purposeOfLoanTxxtfld.placeholder = "enterHere".localized(lang)
        clcEMILocLbl.text = "Total Interest Payable".localized(lang)
        interestAmountLocLbl.text = "Total Interest Payable".localized(lang)
        
        
        selectMobileWalletLocLbl.text = "Select mobile wallet".localized(lang)
        upload3MonthPaySlip.text = "Upload 3 months Pay slip".localized(lang)
        iAcceptLbl.text = "iAccpet".localized(lang)
        termAndCondtionLbl.setTitle("termAcondition".localized(lang), for: .normal)
        nextBtnOutlt.setTitle("Submit".localized(lang), for: .normal)
    }
    
    @IBAction func openTermsAndCondition(_ sender: Any) {
        self.openViewController(controller: TermAndConditionViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
            vc.isBackNavigtn = true
        })
    }
    
    @IBAction func oWallet(_ sender: Any) {
        showTimeSheet(textField: selectMobileWalletTxt)
    }
    
    func showTimeSheet(textField : UITextField){
        if textField == selectMobileWalletTxt {
            let array = self.walletType
            let placeHolder = "List"
            let customStringPicker = ActionSheetStringPicker.init(title:placeHolder, rows: array as [Any], initialSelection:initalValue, doneBlock:
                                                                    { picker, values, indexes in
                                                                        textField.text = (String(describing: indexes ?? ""))
                                                                        self.initalValue = values
                                                                        return
                                                                    }, cancel: nil, origin: textField)
            customStringPicker!.tapDismissAction = TapAction.cancel
            self.view.endEditing(true)
            customStringPicker!.show()
            
        }
        else {
            let array = self.loanPurpose.map{$0.name}
            let placeHolder = "Purpose"
            let customStringPicker = ActionSheetStringPicker.init(title:placeHolder, rows: array as [Any], initialSelection:initalValue, doneBlock:
                                                                    { picker, values, indexes in
                                                                        textField.text = (String(describing: indexes ?? ""))
                                                                        self.intialLoanValue = values
                                                                        return
                                                                    }, cancel: nil, origin: textField)
            customStringPicker!.tapDismissAction = TapAction.cancel
            self.view.endEditing(true)
            customStringPicker!.show()
        }
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
        let interval = 500
        self.lbl_LoanAmount.isHidden = false
        let incomeValue = Int(sender.value / Float(interval) ) * interval
//        let x = Int(round(sender.value))
        lbl_LoanAmount.setTitle("₵\(incomeValue)", for: .normal)
        self.loanAmount = (incomeValue)
        sender.value = Float(incomeValue)
        lbl_LoanAmount.center = setUISliderThumbValueWithLabel(slider: sender)
        setupEMI()
        
    }
    func calculateEmi(loanAmount : Double, loanTenure : Double, interestRate : Double)  {
        let interestRateVal = interestRate / 1200
        let loanTenureVal = loanTenure * 12
        self.totalEMI = Double(loanAmount * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal))))
        self.emiLbl.text =  "₵\(String(format: "%.2f",loanAmount * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal)))))"
    }
    func setupEMI(){
        if self.loaninfo?.interest_type == "reducing" {
            if let intrest = Double(self.loaninfo?.interest ?? "0") {
                let getC = (intrest/1200)
                
                let processing = Double(self.loaninfo?.processingFee ?? "") ?? 0.0
                let totalPV = (Double(loanAmount) * processing)/100
                let finalPrincipalAmout = totalPV + Double(loanAmount)
                self.pmt(rate: getC, nper: Double(tenure), pv: Double(finalPrincipalAmout))
                //                pmt(rate: Double(getC), nper: Double(tenure), pv: Double(totalPV))
                //                print(pmt(rate: 0.018, nper: 24, pv: 10600))
                //                calculateTotalPayment(Double(totalEMI.round(to: 2)), loanTenure: (tenure))
                //                calculateFaltMethod(intRate: 36, pv: Double(10000), tenure: Double(24))
            }
        }
        else{
            if let intrest = Double(self.loaninfo?.interest ?? "0") {
                //            let getC = (intrest/1200)
                let processingFee =  Double(self.loaninfo?.processingFee ?? "") ?? 0.0
                calculateFaltMethod(intRate: intrest, pv: Double(loanAmount).rounded(toPlaces: 2), tenure: Double(tenure), processingFee: processingFee)
            }
        }
        
    }
    
    @IBAction func openpurposeOfLoan(_ sender: Any) {
        showTimeSheet(textField: purposeOfLoanTxxtfld)
    }
    func calculateTotalPayment(_ emi : Double, loanTenure : NSInteger)  {
        //        let totalMonth = (loanTenure * 12)
        self.totalAmount.text = "₵\(String(format: "%.2f",emi * Double(loanTenure)))"
        self.totalPayment = emi * Double(loanTenure).rounded(toPlaces: 2)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func remeberMeAction(_ sender: UIButton) {
        if sender.isSelected {
            isAcceptTermCondition = false
            self.acceptImageView.image = #imageLiteral(resourceName: "uncheck")
        }
        else {
            isAcceptTermCondition = true
            self.acceptImageView.image = #imageLiteral(resourceName: "check")
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func nextAction(_ sender: Any) {
        submitLoanRequest()
    }
    func submitLoanRequest()
    {
        if Validate.shared.validateSubmitLoanPage(vc: self) {
            
            var params =  [String : Any]()
            params["lender"] = self.lenderID
            //            params["loan_type"] = self.loaninfo?.loan_type?.id
            params["purpose"] = self.purposeOfLoanTxxtfld.text ?? ""
            params["amount"] = self.loanAmount
            params["loan_type"] = self.loaninfo?.loan_type?.id
            params["tenure"] = self.tenure
            params["interest"]  = self.loaninfo?.interest
            params["processingFee"] = self.loaninfo?.processingFee
            params["wallet"] = self.selectMobileWalletTxt.text
            params["emi"] = self.totalEMI
            params["loan_product"] = self.loaninfo?.id
            AppManager.init().hudShow()
            ServiceClass.sharedInstance.hitSeriviceForLoanRequest(params, completion: { (type:ServiceClass.ResponseType, parseData:JSON, errorDict:AnyObject?) in
                print_debug("response: \(parseData)")
                AppManager.init().hudHide()
                if (ServiceClass.ResponseType.kresponseTypeSuccess==type){
                    let message = parseData["message"].stringValue
                    Common.showAlert(alertMessage: message, alertButtons: ["Ok"]) { (bt) in
                        //                    self.navigationController?.popViewController(animated: true)
                        appdelegate.setHomeView(selectedIndex: 0)
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
    func pmt(rate : Double, nper : Double, pv : Double, fv : Double = 0, type : Double = 0)   {
        self.totalEMI = ((pv * pvif(rate: rate, nper: nper) - fv) / ((1.0 + rate * type) * fvifa(rate: rate, nper: nper)))
        self.emiLbl.text = "₵\((self.totalEMI).rounded(toPlaces: 2))"
        self.totalAmount.text = "₵\(((totalEMI * Double(tenure)) - pv).rounded(toPlaces: 2))"
        
    }
    func pow1pm1(x : Double, y : Double) -> Double {
        return (x <= -1) ? pow((1 + x), y) - 1 : exp(y * log(1.0 + x)) - 1
    }
    
    func pow1p(x : Double, y : Double) -> Double {
        return (abs(x) > 0.5) ? pow((1 + x), y) : exp(y * log(1.0 + x))
    }
    
    func pvif(rate : Double, nper : Double) -> Double {
        return pow1p(x: rate, y: nper)
    }
    
    func fvifa(rate : Double, nper : Double) -> Double {
        return (rate == 0) ? nper : pow1pm1(x: rate, y: nper) / rate
    }
    
    func calculateFaltMethod(intRate:Double,pv:Double,tenure:Double,processingFee:Double){
        let interestRateVal = intRate / 1200
        let getPocessingFee = (pv * processingFee)/100
        let fPV = pv + getPocessingFee
        let getInterest = (fPV * interestRateVal).rounded(toPlaces: 2)
        let getPrincipalTenure = (fPV / tenure).rounded(toPlaces: 2)
        self.emiLbl.text = "₵\((getInterest + getPrincipalTenure).rounded(toPlaces: 2))"
        
        
        let totalAmountPayable = (getInterest + getPrincipalTenure) * tenure
        self.totalAmount.text = "₵\((totalAmountPayable - fPV))"
        
        
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
