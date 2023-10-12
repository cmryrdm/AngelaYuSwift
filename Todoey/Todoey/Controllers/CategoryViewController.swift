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
  let appearance = UINavigationBarAppearance()
  var categories : Results<Category>?
  var addButton: UIBarButtonItem?
  
  static func instantiate() -> CategoryViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = CategoryViewController(style: .plain)
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
    tableView.separatorStyle = .none
    
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationItem.title = "Todoey"
    
    addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    loadCategories()
  }
  
  // Add new category
  @objc func addButtonPressed() {
    var textField: UITextField?
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Cateogry", style: .default) { action in
      let category = Category()
      category.name = textField?.text ?? ""
      category.colorHex = UIColor.flatWhite().withAlphaComponent(0.1).hexValue()
      self.save(category: category)
    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "Create new category"
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Data manipulation
  func save(category: Category) {
    do {
      try realm.write {
        realm.add(category)
      }
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
  }
  
  func delete(category: Category) {
    do {
      try realm.write {
        realm.delete(category)
      }
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
  }
  
  func loadCategories() {
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"
    if (categories?[indexPath.row]) != nil {
      cell.backgroundColor = UIColor(hexString: categories![indexPath.row].colorHex).darken(byPercentage: CGFloat(indexPath.row) / CGFloat(categories!.count))
    }
    cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if let category = categories?[indexPath.row] {
        delete(category: category)
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
