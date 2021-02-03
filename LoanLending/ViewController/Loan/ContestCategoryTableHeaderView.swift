//
//  ContestCategoryTableHeaderView.swift
//  FantasyCrick2Part
//
//  Created by Developer on 09/05/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ContestCategoryTableHeaderView: UITableViewCell {
    
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet var aTitleLabel: UILabel!
    @IBOutlet var aSubTitleLabel: UILabel!
    
    var viewAllClouser: (() -> Void) = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configureCell(category: MyLoanSection) {
        
        aTitleLabel.text = category.status
//        if let imageUrl = category.contest_type_image {
//            let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            let imageUrl = URL(string: urlString ?? "")
//            aImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
//            }
//
//        }
    }
   
    func configureCell2(category: String) {
        
        aTitleLabel.text = category
//        if let imageUrl = category.contest_type_image {
//            let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            let imageUrl = URL(string: urlString ?? "")
//            aImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
//            }
//
//        }
    }
  
}
