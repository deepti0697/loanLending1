//
//  BankDetailViewController.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit

class BankDetailViewController: UIViewController {

    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var loanTenureLocLbl: UILabel!
    @IBOutlet weak var processngFeeLocLbl: UILabel!
    @IBOutlet weak var intRatLocLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var loanTenureLbl: UILabel!
    @IBOutlet weak var processingFeeLbl: UILabel!
    @IBOutlet weak var rateOInterest: UILabel!
    @IBOutlet weak var loanType: UILabel!
    @IBOutlet weak var bankNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupUIData()
    }
    var bankDetail:LoanList?
    @IBAction func applyLoanAction(_ sender: Any) {
        openViewController(controller: LoanRequestViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
            vc.loaninfo = self.bankDetail
    
                 })
    }
    
    ///Bank Detail description
    func setupUIData(){
        self.bankNameLbl.text = self.bankDetail?.name ?? ""
        self.loanType.text = self.bankDetail?.loanTypes[0].fr_name ?? ""
        
        self.rateOInterest.text = "\(self.bankDetail?.interest ?? "0") %"
        processingFeeLbl.text = "\(self.bankDetail?.processingFee ?? "")"
        self.loanTenureLbl.text = "\(self.bankDetail?.min_tenure ?? "" ) Year"
        self.descriptionLbl.text = "\(self.bankDetail?.description ?? "Testing")"
        if bankDetail?.description == "" || bankDetail?.description == "null" {
            self.descriptionView.isHidden = true
        }
        else {
            self.descriptionView.isHidden = false
        }
    }
    @IBAction func openEMICalculaoatr(_ sender: Any) {
        openViewController(controller: CalculateEMIViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
    
                 })
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
