//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    
    @IBOutlet weak var tenPctButtton: UIButton!
    
    @IBOutlet weak var twentyPctButton: UIButton!
    
    var tipSelected : Double = 0.1
    var tipPercentage : String = ""
    var stepperSelected : Double = 2.0
    var share: Double = 0.0
    var desc: String = ""

    @IBAction func stepperChanged(_ sender: UIStepper) {
        stepperSelected = sender.value
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        billTextField.endEditing(true)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        let tipButtons = [zeroPctButton, tenPctButtton, twentyPctButton]
        
        for btn in tipButtons {
            btn?.isSelected = (btn == sender) ? true : false
        }
        tipPercentage = sender.titleLabel?.text ?? "10%"
        tipSelected = (Double (sender.titleLabel?.text?.replacingOccurrences(of: "%", with: "") ?? "0.0") ?? 0.0) / 100
        billTextField.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let bill = Double(billTextField.text ?? "0") else {return}
        share = bill * (1.0 + tipSelected) / stepperSelected
        
        desc = ("Split between \(stepperSelected) people with \(tipPercentage) tip.")
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToResult" {
                if let destinationVC = segue.destination as? ResultsViewController {
                    destinationVC.share = share
                    destinationVC.desc = desc
                } else {return}
                
            }
        }
    
    
}

