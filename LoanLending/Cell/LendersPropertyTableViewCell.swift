//
//  LendersPropertyTableViewCell.swift
//  LoanLending
//
//  Created by deepti on 19/03/21.
//

import UIKit

class LendersPropertyTableViewCell: UITableViewCell {
    var calulateEMI: (() -> Void) = { }
    var applyloanClosure: (() -> Void) = { }
    @IBOutlet weak var lenderPropertyLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
            super.layoutSubviews()
            
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(response:LoanType){
        lenderPropertyLbl.text = response.name
    }

    @IBAction func applyLoan(_ sender: Any) {
        applyloanClosure()
    }
    
    @IBAction func calculateEMI(_ sender: Any) {
        calulateEMI()
    }
}
