//
//  Const.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 13.10.2023.
//

import Foundation
import ChameleonFramework

struct Const {
  static let storyboard = "Main"
  
  static let categoryBgColor = UIColor.flatSkyBlue()
  static let categoryIdentifier = "CategoryCell"
  static let categoryTitle = "Todoey"
  static let categoryAlertTitle = "Add New Category"
  static let categoryAlertAction = "Add Category"
  static let categoryAlertPlaceholder = "Create new category"
  static let categoryNil = "No Categories Added"
  
  static let itemIdentifier = "TodoItemCell"
  static let backButtonImage = "chevron.backward"
  static let searchBarPlaceholder = "Search"
  static let itemAlertTitle = "Add New Todoey Item"
  static let itemAlertAction = "Add Item"
  static let itemAlertPlaceholder = "Create new item"
  static let itemNil = "No items added"
  
  static let itemSort = "title"
  static let searchQuery = "title CONTAINS[cd] %@"
  static let searchSort = "dateCreated"
}
