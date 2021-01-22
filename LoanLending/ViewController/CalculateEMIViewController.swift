//
//  CalculateEMIViewController.swift
//  LoanLending
//
//  Created by deepti on 19/01/21.
//

import UIKit
//import MaterialComponents.MaterialSlider
class CalculateEMIViewController: UIViewController {
    var distance = "0"
    var lbl_Distance = UIButton()
    @IBOutlet weak var intSlider: UISlider!
//    var slider = MDCSlider()
    override func viewDidLoad() {
        super.viewDidLoad()
//        slider = MDCSlider(frame: CGRect(x: 200, y: 200, width: 100, height: 27))
//        slider.minimumValue = 0
//        slider.maximumValue = 100
//        slider.value = 10
//        slider.isDiscrete = true
//        lbl_Distance.backgroundColor = .yellow
//        lbl_Distance.frame = CGRect(x: 0,y: 32,width: 60,height: 15)
//        lbl_Distance.setTitleColor(.blue, for: .normal)
////        lbl_Distance.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
//        lbl_Distance.setTitle("0" + " km", for: .normal)
//        lbl_Distance.center = setUISliderThumbValueWithLabel(slider: intSlider.self)
//        intSlider.addSubview(lbl_Distance)
////        slider.accessibility
//        lbl_Distance.isHidden = true
////        slider.accessibilityFrame = CGRect(x: 20, y: 20, width: 100, height: 50)
//        slider.numberOfDiscreteValues = 10
////        slider.shouldDisplayDiscreteValueLabel = true
////        slider.trackEndsAreRounded = false
//        slider.isAccessibilityElement = true
////
//
//            slider.isThumbHollowAtStart = false
////        slider.shouldDisplayDiscreteValueLabel = false
//          slider.addTarget(self,
//                           action: #selector(didChangeSliderValue(senderSlider:)),
//                           for: .valueChanged)
//          view.addSubview(slider)
        }
    
//    @IBAction func distancesSliderValueChanged(_ sender: UISlider) {
//        let currentValue = Int(sender.value)
//        print(currentValue)
//        self.lbl_Distance.isHidden = false
//        let x = Int(round(sender.value))
//        lbl_Distance.setTitle("\(x)" + " km", for: .normal)
//        self.distance = "\(x)"
//        lbl_Distance.center = setUISliderThumbValueWithLabel(slider: sender)
//
//    }
//    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
//        let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
//        let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
//        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 16, y: slider.frame.origin.y - 25)
//    }

//    @objc func didChangeSliderValue(senderSlider:MDCSlider) {
//        slider.accessibilityValue = "\(senderSlider.value)"
//
//
//        slider.valueLabelBackgroundColor = .purple
////        slider.filledTrackAnchorValue =
//
//
////        slider.isDiscrete = true
//          print("Did change slider value to: \(senderSlider.value)")
//        }
//        // Do any additional setup after loading the view.
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


