//
//  RetryViewController.swift
//  Lifferent
//
//  Created by sumit sharma on 03/03/21.
//

import UIKit

class RetryViewController: UIView {
    
    var retryButtonComplition : (() -> Void)?
    var center_image: UIImageView?
    var lbl_message: UILabel!
    var btn_title: UIButton!
    
    init(fram : CGRect) {
        super.init(frame: fram)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lbl_message = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: 50))
        lbl_message.center = self.center
        lbl_message.textAlignment = .center
        // lbl_message.frame.origin.y -= 50
        lbl_message.font = UIFont.systemFont(ofSize: 15)
        lbl_message.numberOfLines = 0
        self.addSubview(lbl_message)
        
        center_image = UIImageView.init(frame: CGRect.init(x:(frame.width - 120)/2 , y: lbl_message.frame.maxY - 170, width: 120, height: 120))
        center_image?.contentMode = .center
        self.addSubview(center_image ?? UIImageView())
        
        btn_title = UIButton.init(frame: CGRect.init(x: (frame.width - 160)/2, y: lbl_message.frame.maxY + 10, width: 160, height: 40))
        btn_title.layer.cornerRadius = btn_title.frame.size.height / 2
        btn_title.backgroundColor = UIColor.lightGray
        //        btn_title.borderWidth = 1
        //        btn_title.setTitle("Retry", for: .normal)
        btn_title.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        btn_title.setTitleColor(UIColor.white, for: .normal)
        self.addSubview(btn_title)
        lbl_message.textColor = .lightGray
        print("LabelMadness.initWithFrame:")
        // Customize logic
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        // super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonAction(_ sender: Any) {
        if let comp = retryButtonComplition {
            comp()
        }
    }
}
