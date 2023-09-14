//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var bmiBrain = BmiBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func heightSliderUsed(_ sender: UISlider) {
        heightLabel.text = String(format: "%.2f m", sender.value)
    }
    
    @IBAction func weightSliderUsed(_ sender: UISlider) {
        weightLabel.text = String(format: "%.0f kg", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        bmiBrain.calculateBmi(weight: weightSlider.value, height: heightSlider.value)
        
        performSegue(withIdentifier: "goToResult", sender: self) // self.performSegue
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            if let destinationVC = segue.destination as? ResultViewController {
                destinationVC.bmiBrain = bmiBrain
            } else {return}
            
        }
    }
    
}

