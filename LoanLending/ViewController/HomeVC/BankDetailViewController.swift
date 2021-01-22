//
//  BankDetailViewController.swift
//  LoanLending
//
//  Created by deepti on 18/01/21.
//

import UIKit

class BankDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func applyLoanAction(_ sender: Any) {
        openViewController(controller: LoanRequestViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
    
                 })
    }
    @IBAction func openEMICalculaoatr(_ sender: Any) {
        openViewController(controller: CalculateEMIViewController.self, storyBoard: .mainStoryBoard, handler: { (vc) in
    
                 })
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
