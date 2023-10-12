//
//  ViewController.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 2.10.2023.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: UITableViewController {
  let realm = try! Realm()
  let appearance = UINavigationBarAppearance()
  var todoItems : Results<Item>?
  var addButton: UIBarButtonItem?
  var backButton: UIBarButtonItem?
  var searchBar: UISearchBar?
  var selectedCategory: Category? {
    didSet {
      loadItems()
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
    tableView.separatorStyle = .none
    
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationItem.title = "Items"
    
    addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonPressed))
    navigationItem.leftBarButtonItem = backButton
    navigationItem.leftBarButtonItem?.tintColor = .white
    
    searchBar = UISearchBar()
    searchBar?.placeholder = "Search"
    searchBar?.delegate = self
    searchBar?.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
    tableView.tableHeaderView = searchBar
  }
  
  @objc func addButtonPressed() {
    var textField: UITextField?
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    
    
    let action = UIAlertAction(title: "Add Item", style: .default) { action in
      if let currentCategory = self.selectedCategory {
        do {
          try self.realm.write {
            let item = Item()
            item.title = textField?.text ?? ""
            item.dateCreated = Date()
            currentCategory.items.append(item)
          }
        } catch {
          print(error.localizedDescription)
        }
      }
      self.tableView.reloadData()
    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  @objc func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
  func delete(item: Item) {
    do {
      try realm.write {
        realm.delete(item)
      }
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
  }
  
  // if no value passed Item.fetchRequest() called!
  func loadItems() {
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    tableView.reloadData()
  }
  
  //MARK: - Tableview datasource methods
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
    if let item = todoItems?[indexPath.row] {
      cell.textLabel?.text = item.title
      cell.accessoryType = item.done ? .checkmark : .none
      if let colorHex = selectedCategory?.colorHex {
        cell.backgroundColor = UIColor(hexString: colorHex).darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count))
        cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
      }
    } else {
      cell.textLabel?.text = "No items added"
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if let item = todoItems?[indexPath.row] {
        delete(item: item)
      }
    }
  }
  
  //MARK: - Tableview delegate methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let item = todoItems?[indexPath.row] {
      do {
        try realm.write {
          item.done = !item.done
        }
      } catch {
        print(error.localizedDescription)
      }
    }
    tableView.reloadData()
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  
  
}

// MARK: - SearchBar delegate methods
extension TodoListViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
    tableView.reloadData()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      loadItems()
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }
    }
  }
}

