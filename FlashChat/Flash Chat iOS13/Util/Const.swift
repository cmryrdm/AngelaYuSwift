//
//  Util.swift
//  Flash Chat iOS13
//
//  Created by CEMRE YARDIM on 23.09.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

struct Const {
  static let appName = "⚡️FlashChat"
  
  static let phEmail = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.gray])
  static let phPassword = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.gray])
  
  static let cellIdentifier = "ReusableCell"
  static let cellNibName = "MessageCell"
  static let registerSegue = "RegisterToChat"
  static let loginSegue = "LoginToChat"
  static let welcomeRegisterSegue = "WelcomeToRegister"
  static let welcomeLoginSegue = "WelcomeToLogin"
  
  struct BrandColors {
    static let purple = "BrandPurple"
    static let lightPurple = "BrandLightPurple"
    static let blue = "BrandBlue"
    static let lighBlue = "BrandLightBlue"
  }
  
  struct FStore {
    static let collectionName = "messages"
    static let senderField = "sender"
    static let bodyField = "body"
    static let dateField = "date"
  }
  
}
