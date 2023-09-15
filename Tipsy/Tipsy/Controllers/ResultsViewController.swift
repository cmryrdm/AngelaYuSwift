//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by CEMRE YARDIM on 14.09.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    var share: Double?
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let share = share {
            totalLabel.text = String(format: "%.1f", share)
        }
        settingsLabel.text = desc
        
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
