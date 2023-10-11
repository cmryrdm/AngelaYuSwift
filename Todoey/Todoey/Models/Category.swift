//
//  Category.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 11.10.2023.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  let items = List<Item>()  // forward relationship
}
