//
//  HomeTableCollectionViewCell.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit
import SDWebImage
class HomeTableCollectionViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.calculateEMIOtlt.setTitle("Calculate EMI".localized(lang), for: .normal)
    }
    var lang = AppHelper.getStringForKey(ServiceKeys.languageType)
    var calulateEMI: (() -> Void) = { }
    
    @IBOutlet weak var calculateEMIOtlt: UIButton!
    
    @IBOutlet weak var logp: UIImageView!
    @IBOutlet weak var rateOfIneterest: UILabel!
    @IBOutlet weak var processingFeeLbl: UILabel!
    @IBOutlet weak var bankNamelbl: UILabel!
    override func layoutSubviews() {
            super.layoutSubviews()
            
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    
    
    func configureCell(response:LoanList) {
        self.bankNamelbl.text = response.name
        self.rateOfIneterest.text = "\(response.interest ?? "")% Rate of Interest"
        self.processingFeeLbl.text = "Processing fee: $\(response.processingFee ?? "")"
        if let imageStr = response.logo{
            print(imageStr)
           
            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            logp?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "ino-image"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
    }
    @IBAction func calculateEMI(_ sender: Any) {
        calulateEMI()
    }
}
