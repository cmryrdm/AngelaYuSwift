//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by CEMRE YARDIM on 14.09.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiBrain: BmiBrain?
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = String(format: "%.1f", bmiBrain?.getValue() ?? 0)
        adviceLabel.text = bmiBrain?.getAdvice() ?? ""
        view.backgroundColor = bmiBrain?.getColor() ?? .systemBackground
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil) // self.dismiss
    }
    
    
    

}
