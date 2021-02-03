//
//  LoanTableViewCell.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit

class LoanTableViewCell: UITableViewCell {
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    @IBOutlet weak var tenureLbl: UILabel!
    var releaseDate: NSDate?
    @IBOutlet weak var loanTypeLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var puproseLbl: UILabel!
    @IBOutlet weak var loanTypeLocLbl: UILabel!
    @IBOutlet weak var tenureLocLbl: UILabel!
    @IBOutlet weak var dobLocLbl: UILabel!
    @IBOutlet weak var purposeLocLbl: UILabel!
    @IBOutlet weak var interestLocLbl: UILabel!
    @IBOutlet weak var interestLbl: UILabel!
    @IBOutlet weak var loanIDLbl: UILabel!
    @IBOutlet weak var loanIDLocLbl: UILabel!
    @IBOutlet weak var loanAmountLocLbl: UILabel!
    @IBOutlet weak var loanAmountAndEMiLbl: UILabel!
  
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var calculateEMI: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpLocalizableString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    override func layoutSubviews() {
            super.layoutSubviews()
            
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        }
    func confirgureCell(response:MyLoanList){
     
        self.bankNameLbl.text = "\(response.lender?.name ?? "")"
        self.loanAmountAndEMiLbl.text = "\(response.amount ?? ""), \(response.tenure ?? "") EMI"
        self.loanIDLbl.text = response.loanId ?? ""
        self.interestLbl.text = "\(response.intersest ?? "")%"
        self.puproseLbl.text = response.purpose ?? ""
//        setReleaseTime(releaseDateString: response.created_at ?? "")
        self.tenureLbl.text = response.tenure
        loanTypeLbl.text = response.loan_type?.fr_name
    
    }
    
    func setUpLocalizableString(){
        self.loanAmountLocLbl.text = "Loan Amount & EMI ".localized(lang)
        self.loanIDLocLbl.text = "Loan ID".localized(lang)
        self.interestLocLbl.text  = "Interest Rate".localized(lang)
        self.interestLocLbl.text =
            "Purpose".localized(lang)
        self.dobLocLbl.text = "Date of Loan".localized(lang)
        self.tenureLocLbl.text = "Tenure".localized(lang)
        self.loanTypeLocLbl.text = "Loan Type".localized(lang)
        

    }
    fileprivate func setReleaseTime(releaseDateString: String) {
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.year,.month,.day], from: currentDate, to: releaseDate! as Date)
        var year = diffDateComponents.year ?? 00
        var month = diffDateComponents.month ?? 00
        var day = diffDateComponents.day ?? 00
        
        if day < 0 {
            day = 0
        }
        if year < 0 {
            year = 0
        }
        if month < 0 {
            month = 0
        }
        
        let countdown = "\(Utility.getStringFrom(seconds: year))H \(Utility.getStringFrom(seconds: month))M \(Utility.getStringFrom(seconds: day))S"
        dobLbl.text = countdown
       
    }
}







