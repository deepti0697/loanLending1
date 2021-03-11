//
//  LoanTableViewCell.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit
import SDWebImage
class LoanTableViewCell: UITableViewCell {
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
   
    @IBOutlet weak var interestLocLbl: UILabel!
    @IBOutlet weak var interestLbl: UILabel!
    @IBOutlet weak var loanIDLbl: UILabel!
    @IBOutlet weak var loanIDLocLbl: UILabel!
    @IBOutlet weak var loanAmountLocLbl: UILabel!
    @IBOutlet weak var loanAmountAndEMiLbl: UILabel!
  
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var calculateEMI: UIButton!
    
    var countdownTimer = Timer()
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
        self.loanAmountAndEMiLbl.text = "₵\(response.amount ?? ""), \(response.tenure ?? "") Monthly Repayment"
        self.loanIDLbl.text = response.loanId ?? ""
        self.interestLbl.text = "\(response.interest ?? "")%"
//        self.puproseLbl.text = response.purpose ?? ""
//        if let time = response.created_at {
//          stringToDate(date: time)
//        }
//        self.tenureLbl.text = "\(response.tenure ?? "")"
//        loanTypeLbl.text = response.loan_type?.fr_name
        if let imageStr = response.lender?.logo{
            print(imageStr)
           
            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            imageLogo?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "ino-image"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
    
    }
    
    func setUpLocalizableString(){
        self.loanAmountLocLbl.text = "Loan Amount & Monthly Repayment ".localized(lang)
        self.loanIDLocLbl.text = "Loan ID".localized(lang)
        self.interestLocLbl.text  = "Interest Rate".localized(lang)
//
//        self.dobLocLbl.text = "Date of Loan".localized(lang)
//        self.tenureLocLbl.text = "Tenure".localized(lang)
//        self.loanTypeLocLbl.text = "Loan Type".localized(lang)
//

    }
    fileprivate func setReleaseTime(releaseDateString: String) {
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.locale = Locale(identifier: "en_US_POSIX")

        releaseDateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = releaseDateFormatter.date(from: releaseDateString) else {
           fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
//        releaseDate = date as NSDate
//        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
//    @objc func updateTime() {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
//        var year = diffDateComponents.year ?? 00
//        var month = diffDateComponents.month ?? 00
//        var day = diffDateComponents.day ?? 00
//
//        if day < 0 {
//            day = 0
//        }
//        if year < 0 {
//            year = 0
//        }
//        if month < 0 {
//            month = 0
//        }
//
//        let countdown = "\(Utility.getStringFrom(seconds: year))H \(Utility.getStringFrom(seconds: month))M \(Utility.getStringFrom(seconds: day))S"
//        dobLbl.text = countdown
//
//    }
//    func stringToDate(date: String)  {
//        let formatter = DateFormatter()
//
//        let splitedDate = date.components(separatedBy: "T")
//        if splitedDate.count > 0 {
//            formatter.dateFormat = "yyyy/MM/dd"
////            if let parsedDate = formatter.date(from: splitedDate[0]) {
//                self.dobLbl.text = "\(splitedDate[0])"
////            }
//        }
//        // Format 1
////        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
////        if let parsedDate = formatter.date(from: date) {
////            return parsedDate
////        }
////
////        // Format 2
////        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
////        if let parsedDate = formatter.date(from: date) {
////            return parsedDate
////        }
//
//        // Couldn't parsed with any format. Just get the date
//
//
//        // Nothing worked!
//
//    }
//    func monthsToYeaar(months:String) -> String{
//        let converet = Int(months) / 12
//        return "\(converet) Years"
//    }
}




