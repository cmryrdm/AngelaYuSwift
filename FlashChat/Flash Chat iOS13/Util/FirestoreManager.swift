//
//  FirestoreManager.swift
//  Flash Chat iOS13
//
//  Created by CEMRE YARDIM on 26.09.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager {
  static let shared = FirestoreManager()
  
  private init() {
    // No need to configure FirebaseApp here, it should be done in AppDelegate
  }
  
  let db = Firestore.firestore()
}
