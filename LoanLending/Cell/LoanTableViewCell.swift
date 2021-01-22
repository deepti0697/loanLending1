//
//  LoanTableViewCell.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit

class LoanTableViewCell: UITableViewCell {

    @IBOutlet weak var calculateEMI: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
            super.layoutSubviews()
            
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        }
}
