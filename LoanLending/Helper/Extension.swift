//
//  Extension.swift
//  LoanLending
//
//  Created by Subhash on 12/01/21.
//

import Foundation
import UIKit
import FAPanels
extension String {
    func localized(_ lang:String) ->String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")!
        let bundle = Bundle(path: path)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
    
    public func LeftView(of image: UIImage?) {
        
        //setting left image
        if(image == nil)
        {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            self.leftView = paddingView
        }
        else
        {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            if let image = image {
                let paddingImage = UIImageView()
                paddingImage.image = image
                paddingImage.contentMode = .left
                paddingImage.frame = CGRect(x: 8, y: 0, width: 18, height: 40)
                paddingView.addSubview(paddingImage)
            }
            self.leftView = paddingView
        }
        self.leftView?.isUserInteractionEnabled = false
        self.leftViewMode = UITextField.ViewMode.always
        
        
    }
    
    public func RightViewImage(_ textFieldImg: UIImage?) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        if let image = textFieldImg {
            let paddingImage = UIImageView()
            paddingImage.image = image
            paddingImage.contentMode = .center
            paddingImage.frame = CGRect(x: 6, y: 6, width: 14, height: 18)
            paddingView.addSubview(paddingImage)
        }
        self.rightView = paddingView
        self.rightViewMode = UITextField.ViewMode.always
    }
    
    public func textFldLayer() {
        
        layer.borderWidth = 0.50;
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

internal protocol StoryboardIdentifiable {
    
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UIViewController: StoryboardIdentifiable {
    
}

extension UIStoryboard {
    
    enum Storyboard: String {
        case mainStoryBoard = "Main"
       
        var filename: String {
            return rawValue.description
        }
    }
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}
extension UIViewController {
    func openViewController<T: UIViewController>(controller: T.Type, storyBoard: UIStoryboard.Storyboard, handler: @escaping (T) -> Void) {
        let storyBoard = UIStoryboard(storyboard: storyBoard)
        let vc: T = storyBoard.instantiateViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        handler(vc)
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor : newValue!])
        }
    }
}
public extension UIViewController {
    
    //  Get Current Active Panel
    var panel: FAPanelController? {
        
        get{
            var iter:UIViewController? = self.parent
            
            while (iter != nil) {
                if iter is FAPanelController {
                    return iter as? FAPanelController
                }else if (iter?.parent != nil && iter?.parent != iter) {
                    iter = iter?.parent
                }else {
                    iter = nil
                }
            }
            return nil
        }
    }
    
    class var storyboardID : String {
        
        return "\(self)"
    }
    
}
extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if(UIScreen.main.bounds.height == 812) {
            sizeThatFits.height = (UIScreen.main.bounds.height*11.5)/100 // adjust your size here
        }
        else {
            sizeThatFits.height = (UIScreen.main.bounds.height*9.5)/100 // adjust your size here
        }
        
        
        return sizeThatFits
    }
}
extension UIView {
    

         func blink() {
             self.alpha = 0.2
             UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
         }
    


    func addMistCornerRadius(corners : UIRectCorner =  [ .topRight , .topLeft]) {
    
    let rectShape = CAShapeLayer()
       rectShape.bounds = self.frame
       rectShape.position = self.center
       rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 22, height: 22)).cgPath
        self.layer.mask = rectShape
    
    }
  // OUTPUT 2
  func dropShadow(cornerRadius: CGFloat, maskedCorners: CACornerMask, color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat) {
  self.layer.cornerRadius = cornerRadius
    if #available(iOS 11.0, *) {
        self.layer.maskedCorners = maskedCorners
    } else {
    }
           self.layer.shadowColor = color.cgColor
           self.layer.shadowOffset = offset
           self.layer.shadowOpacity = opacity
           self.layer.shadowRadius = shadowRadius
  }
}

