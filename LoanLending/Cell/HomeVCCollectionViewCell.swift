//
//  HomeVCCollectionViewCell.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit
import SDWebImage
class HomeVCCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var loanTypeLabel: UILabel!
    @IBOutlet weak var topImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
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
