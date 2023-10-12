//
//  Item.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 11.10.2023.
//

import Foundation
import RealmSwift

class Item: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var done: Bool = false
  @objc dynamic var dateCreated: Date?
  var parentCategory = LinkingObjects(fromType: Category.self, property: "items") // inverse relationship
}
