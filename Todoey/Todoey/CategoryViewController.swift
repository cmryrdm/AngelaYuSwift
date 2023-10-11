//
//  CategoryViewController.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 10.10.2023.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
  
  let appearance = UINavigationBarAppearance()
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var categoryArray = [Category]()
  var addButton: UIBarButtonItem?
  
  static func instantiate() -> CategoryViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = CategoryViewController(style: .plain)
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
    
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationItem.title = "Todoey"
    
    addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    self.loadCategories()
  }
  
  // Add new item
  @objc func addButtonPressed() {
    var textField: UITextField?
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Cateogry", style: .default) { action in
      let category = Category(context: self.context)
      category.name = textField?.text
      self.categoryArray.append(category)
      self.saveCategories()
    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "Create new category"
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Data manipulation
  func saveCategories() {
    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
    self.tableView.reloadData()
  }
  
  func loadCategories() {
    do {
      categoryArray = try context.fetch(Category.fetchRequest())
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
  }

  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    let category = categoryArray[indexPath.row]
    cell.textLabel?.text = category.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      context.delete(categoryArray[indexPath.row])
      categoryArray.remove(at: indexPath.row)
      saveCategories()
    }
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = TodoListViewController.instantiate()
    destinationVC.selectedCategory = categoryArray[indexPath.row]
    //self.present(TodoListViewController.instantiate(), animated: true)
    self.navigationController?.pushViewController(destinationVC, animated: true)
    //tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}
