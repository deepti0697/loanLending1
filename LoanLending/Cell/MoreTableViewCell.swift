//
//  MoreTableViewCell.swift
//  FantasyCricket
//
//  Created by Developer on 14/09/1440 AH.
//  Copyright © 1440 Rickey_iDev. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var aMoreSubTitleView: UIView!
    @IBOutlet weak var aMoreSubTitleLabel: UILabel!
    @IBOutlet weak var aImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
//        aMoreTitleView.isHidden = true
        aMoreSubTitleView.isHidden = true
//        aMoreTitleLabel.text = ""
        aMoreSubTitleLabel.text = ""
    }

    func configCell(imageName: String, title: String, showTitle: Bool) {
//        if showTitle {
//            aMoreTitleLabel.text = title
//            aMoreSubTitleView.isHidden = true
//            aMoreTitleView.isHidden = false
//        } else {
//            aMoreTitleView.isHidden = true
            aMoreSubTitleView.isHidden = false
            self.aMoreSubTitleLabel.text = title
            self.aImageView.image = UIImage(named: imageName)
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
