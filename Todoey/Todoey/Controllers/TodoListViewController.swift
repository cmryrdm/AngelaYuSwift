//
//  ViewController.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 2.10.2023.
//

import UIKit
import CoreData
import SnapKit

class TodoListViewController: UITableViewController {
  
  let appearance = UINavigationBarAppearance()
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var itemArray = [Item]()
  var addButton: UIBarButtonItem?
  var backButton: UIBarButtonItem?
  var searchBar: UISearchBar?
  var selectedCategory: Category? {
    didSet {
//      loadItems()
    }
  }
  
  static func instantiate() -> TodoListViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = TodoListViewController(style: .plain)
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoItemCell")
    
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationItem.title = "Items"
    
//    addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonPressed))
    navigationItem.leftBarButtonItem = backButton
    navigationItem.leftBarButtonItem?.tintColor = .white
    
    searchBar = UISearchBar()
    searchBar?.placeholder = "Search"
//    searchBar?.delegate = self
    searchBar?.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
    tableView.tableHeaderView = searchBar
  }
  
//  @objc func addButtonPressed() {
//    var textField: UITextField?
//    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
//    
//    let action = UIAlertAction(title: "Add Item", style: .default) { action in
//      let item = Item(context: self.context)
//      item.title = textField?.text ?? ""
//      item.parentCategory = self.selectedCategory
//      item.done = false
//      self.itemArray.append(item)
//      self.saveItems()
//    }
//    
//    alert.addTextField { alertTextField in
//      alertTextField.placeholder = "Create new item"
//      textField = alertTextField
//    }
//    
//    alert.addAction(action)
//    present(alert, animated: true, completion: nil)
//  }
  
  @objc func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
  
  func saveItems() {
    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
    self.tableView.reloadData() // to show the new item on the tableView
  }
  
  // if no value passed Item.fetchRequest() called!
//  func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), including predicate: NSPredicate? = nil) {
//    let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//    
//    if let additionalPredicate = predicate {
//      request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate,categoryPredicate])
//    } else {
//      request.predicate = categoryPredicate
//    }
//    
//    do {
//      itemArray = try context.fetch(request)
//    } catch {
//      print(error.localizedDescription)
//    }
//    tableView.reloadData()
//    
//  }
  
  
  //MARK: - Tableview datasource methods
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
    let item = itemArray[indexPath.row]
    cell.textLabel?.text = item.title
    cell.accessoryType = item.done ? .checkmark : .none
    return cell
  }
  
//  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//      context.delete(itemArray[indexPath.row])
//      itemArray.remove(at: indexPath.row)
//      saveItems()
//    }
//  }
  
  //MARK: - Tableview delegate methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = itemArray[indexPath.row]
    item.done = !item.done
    
    saveItems()
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  
  
}

//MARK: - SearchBar delegate methods
//extension TodoListViewController: UISearchBarDelegate {
//  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    let request: NSFetchRequest<Item> = Item.fetchRequest()
//    // c: case & d: diacritic insensitivity
//    let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//    loadItems(with: request, including: predicate)
//  }
//  
//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    if searchBar.text?.count == 0 {
//      loadItems()
//      DispatchQueue.main.async {
//        searchBar.resignFirstResponder()
//      }
//    }
//  }
//}

