//
//  CalculateEMIViewController.swift
//  LoanLending
//
//  Created by deepti on 19/01/21.
//

import UIKit
//import MaterialComponents.MaterialSlider
class CalculateEMIViewController: UIViewController {
    var loanAmount = 50000
    var interest = 1
    var tenure = 1
    var totalEMI = 0.0
    var totalPayment = 0.0
    var lbl_LoanAmount = UIButton()
    var lbl_Interest = UIButton()
    var lbl_Tenure = UIButton()
    @IBOutlet weak var loanAmountSlider: UISlider!
    @IBOutlet weak var tenureSlider: UISlider!
    @IBOutlet weak var interestSlider: UISlider!
   
    @IBOutlet weak var maximumSliderLabel: UILabel!
    @IBOutlet weak var minmumSliderLabel: UILabel!
    @IBOutlet weak var doneOutltLoc: UIButton!
    @IBOutlet weak var tenureLocLbl: UILabel!
    @IBOutlet weak var interestLocLbl: UILabel!
    @IBOutlet weak var loanAmountLocLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var totalInterestLbl: UILabel!
    @IBOutlet weak var totalEmiLbl: UILabel!
    //    var slider = MDCSlider()
    @IBOutlet weak var loanEMILocLbl: UILabel!
    var getLoanData:LoanList?
    @IBOutlet weak var totalAmountPaybleLocLbl: UILabel!
    @IBOutlet weak var totalInterstPayableLocLbl: UILabel!
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    override func viewDidLoad() {
        super.viewDidLoad()
      
      SliderLabels()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.minmumSliderLabel.text = "\(self.getLoanData?.min_tenure ?? "") Months"
        self.maximumSliderLabel.text = "\(self.getLoanData?.max_tenure ?? "") Months"
        tenureSlider.minimumValue = Float(self.getLoanData?.min_tenure ?? "") ?? 0.0
        tenureSlider.maximumValue = Float(self.getLoanData?.max_tenure ?? "") ?? 0.0
        tenure = Int(Float(self.getLoanData?.min_tenure ?? "") ?? 0.0)
    }
    
    func setuplocalizable(){
        loanEMILocLbl.text = "Loan EMI".localized(lang)
        totalAmountPaybleLocLbl.text = "Total Amount Payable".localized(lang)
        totalInterstPayableLocLbl.text = "Total Interest Payable".localized(lang)
        loanAmountLocLbl.text = "Loan Amount".localized(lang)
        interestLocLbl.text = "Loan Amount".localized(lang)
        tenureLocLbl.text =  "Tenure".localized(lang)
        doneOutltLoc.setTitle("Apply Loan".localized(lang), for: .normal)
    }

    func SliderLabels(){
        lbl_LoanAmount.layer.cornerRadius = 5
        lbl_Tenure.layer.cornerRadius = 5
        lbl_Interest.layer.cornerRadius = 5
        
        lbl_LoanAmount.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_LoanAmount.frame = CGRect(x: 0,y: 32,width: 100,height: 25)
        
        lbl_LoanAmount.setTitleColor(.white, for: .normal)
//        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_LoanAmount.setTitle("0", for: .normal)
        lbl_LoanAmount.center = setUISliderThumbValueWithLabel(slider: loanAmountSlider.self)
        loanAmountSlider.addSubview(lbl_LoanAmount)
        lbl_LoanAmount.isHidden = true
        
        
        lbl_Interest.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_Interest.frame = CGRect(x: 0,y: 32,width: 60,height: 25)
        lbl_Interest.setTitleColor(.white, for: .normal)
//        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_Interest.setTitle("0" + "%", for: .normal)
        lbl_Interest.center = setUISliderThumbValueWithLabel(slider: interestSlider.self)
        interestSlider.addSubview(lbl_Interest)
        lbl_Interest.isHidden = true
        
        
        lbl_Tenure.backgroundColor = UIColor(red: 37/255, green: 193/255, blue: 255/255, alpha: 1)
        lbl_Tenure.frame = CGRect(x: 0,y: 32,width: 100,height: 25)
        lbl_Tenure.setTitleColor(.white, for: .normal)
//        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl_Tenure.setTitle("0" + " Months", for: .normal)
        lbl_Tenure.center = setUISliderThumbValueWithLabel(slider: tenureSlider.self)
        tenureSlider.addSubview(lbl_Tenure)
        lbl_Tenure.isHidden = true

        
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
    
    @IBAction func intresetSliderValueChnaged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        print(currentValue)
        self.lbl_Interest.isHidden = false
        let x = Int(round(sender.value))
        lbl_Interest.setTitle("\(x)" + " %", for: .normal)
        self.interest = (x)
        lbl_Interest.center = setUISliderThumbValueWithLabel(slider: sender)
        setupEMI()
    }
    
    @IBAction func distancesSliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        print(currentValue)
        self.lbl_LoanAmount.isHidden = false
        let x = Int(round(sender.value))
        lbl_LoanAmount.setTitle("₵\(x)", for: .normal)
        self.loanAmount = (x)
        lbl_LoanAmount.center = setUISliderThumbValueWithLabel(slider: sender)
        setupEMI()

    }
    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
        let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 16, y: slider.frame.origin.y - 30)
    }


//        // Do any additional setup after loading the view.
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func doneAmount(_ sender: Any) {
        openViewController(controller: LoanRequestViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
            vc.loaninfo = self.getLoanData
        })
      
    }
    func calculateEmi(loanAmount : Double, loanTenure : Double, interestRate : Double)  {
        let interestRateVal = interestRate / 1200
        let loanTenureVal = loanTenure * 12
        self.totalEMI = Double(loanAmount * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal))))
        self.totalEmiLbl.text =  "₵\(String(format: "%.2f",loanAmount * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal)))))"
    }
    func setupEMI(){
        calculateEmi(loanAmount: Double(loanAmount), loanTenure: Double(tenure), interestRate: Double(interest))
        calculateTotalPayment(Double(totalEMI), loanTenure: (tenure))
        calculateTotalInterestPayable(totalPayment, loanAmount: Double(loanAmount))
    }
    func calculateTotalPayment(_ emi : Double, loanTenure : NSInteger)  {
        let totalMonth = loanTenure * 12
        self.totalAmountLbl.text = "₵\(String(format: "%.2f",emi * Double(totalMonth)))"
        self.totalPayment = emi * Double(totalMonth)
    }
    
    func calculateTotalInterestPayable(_ totalPayment : Double, loanAmount : Double) {
        self.totalInterestLbl.text =  "₵\(String(format: "%.2f",totalPayment - loanAmount))"
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


