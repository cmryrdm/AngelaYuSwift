//
//  CategoryViewController.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 10.10.2023.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: UITableViewController {
  let realm = try! Realm()
  var categories : Results<Category>?
  var addButton: UIBarButtonItem?
  
  // Coordinator?
  static func instantiate() -> CategoryViewController {
    let storyboard = UIStoryboard(name: Const.storyboard, bundle: nil)
    let viewController = CategoryViewController(style: .plain)
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.categoryIdentifier)
    tableView.separatorStyle = .none
    tableView.backgroundColor = Const.categoryBgColor
    navigationItem.title = Const.categoryTitle
    
    // Coordinator?
    navigationController?.navigationBar.barTintColor = .clear
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    
    addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.rightBarButtonItem?.tintColor = .white // OK?
    
    load()
  }
  
  // Add new category
  @objc func addButtonPressed() {
    var textField: UITextField?
    let alert = UIAlertController(title: Const.categoryAlertTitle, message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: Const.categoryAlertAction, style: .default) { action in
      let category = Category()
      category.name = textField?.text ?? ""
      category.colorHex = UIColor.randomFlat().hexValue()
      self.save(category)
    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = Const.categoryAlertPlaceholder
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Data manipulation
  func save(_ category: Category) {
    do {
      try realm.write {
        realm.add(category)
      }
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
  }
  
  func delete(_ category: Category) {
    do {
      try realm.write {
        realm.delete(category)
      }
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
  }
  
  func load() {
    categories = realm.objects(Category.self)
    tableView.reloadData()
  }

  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Const.categoryIdentifier, for: indexPath)
    cell.textLabel?.text = categories?[indexPath.row].name ?? Const.categoryNil
    if (categories?[indexPath.row]) != nil {
      cell.backgroundColor = UIColor(hexString: categories![indexPath.row].colorHex)//.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(categories!.count))
    }
    cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if let category = categories?[indexPath.row] {
        delete(category)
      }
    }
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = TodoListViewController.instantiate()
    destinationVC.selectedCategory = categories?[indexPath.row]
    self.navigationController?.pushViewController(destinationVC, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}
