//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceImageNames = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
    
    var randomIndex1: Int?
    
    
    // IBOutlet allows to reference to UI element
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        // Generate random index to select a dice image
        randomIndex1 = Int.random(in: 0..<diceImageNames.count)
                
        // Set dice images using randomly selected image names
        diceImageView1.image = UIImage(named: diceImageNames[randomIndex1 ?? 0])
        diceImageView2.image = UIImage(named: diceImageNames.randomElement() ?? diceImageNames[0])
    }
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let button = UIButton()
//        rollButtonPressed(button)
    }


}

