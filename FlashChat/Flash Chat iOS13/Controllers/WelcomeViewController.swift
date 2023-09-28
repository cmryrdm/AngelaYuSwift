//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
//import CLTypingLabel

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel! //CLTypingLabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleText = Const.appName
    var charIndex = 0.0
    titleLabel.text = ""
    for letter in titleText {
      Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
        self.titleLabel.text?.append(letter)
      }
      charIndex += 1
    }
    
  }
  
  @IBAction func registerPressed(_ sender: UIButton) {
    self.performSegue(withIdentifier: Const.welcomeRegisterSegue, sender: self)
  }
  
  
  @IBAction func loginPressed(_ sender: UIButton) {
    self.performSegue(withIdentifier: Const.welcomeLoginSegue, sender: self)
  }
  
  
  
  
}
