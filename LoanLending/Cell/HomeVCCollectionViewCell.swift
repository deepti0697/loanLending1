//
//  HomeVCCollectionViewCell.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit
import SDWebImage
class HomeVCCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundViewC: UIView!
    @IBOutlet weak var loanTypeLabel: UILabel!
    @IBOutlet weak var topImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
//    override var isSelected: Bool {
//        didSet {
//            // TODO: replace .red & .blue with desired colors
//            loanTypeLabel.textColor = isSelected ? UIColor(red: 26/155, green: 178/255, blue: 241/255, alpha: 1) : #colorLiteral(red: 0.5060961843, green: 0.5214104056, blue: 0.6324416399, alpha: 1)
//            backgroundViewC?.layer.borderColor = isSelected ? UIColor(red: 26/155, green: 178/255, blue: 241/255, alpha: 1).cgColor : #colorLiteral(red: 0.5060961843, green: 0.5214104056, blue: 0.6324416399, alpha: 1)
//            backgroundViewC.layer.borderWidth = isSelected ? 2 : 0
//            
//        }
//    }
    
    func configureCell(response:LoanType) {
        self.loanTypeLabel.text = response.name
        if let imageStr = response.logo{
            print(imageStr)
           
            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            topImgView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "ino-image"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
        
    }

}
