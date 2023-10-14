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
  var todoItems : Results<Item>?
  var addButton: UIBarButtonItem?
  var backButton: UIBarButtonItem?
  var searchBar: UISearchBar?
  var selectedCategory: Category? {
    didSet {
      load()
    }
  }
  
  static func instantiate() -> TodoListViewController {
    let storyboard = UIStoryboard(name: Const.storyboard, bundle: nil)
    let viewController = TodoListViewController(style: .plain)
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar = UISearchBar()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.itemIdentifier)
    tableView.separatorStyle = .none
    
    navigationController?.navigationBar.barTintColor = .clear
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
   
    if let colorHex = selectedCategory?.colorHex {
      navigationItem.title = selectedCategory!.name
      tableView.backgroundColor = UIColor(hexString: colorHex)
      searchBar?.barTintColor = UIColor(hexString: colorHex)
      navigationController?.navigationBar.tintColor = UIColor(contrastingBlackOrWhiteColorOn: UIColor(hexString: colorHex), isFlat: true)
    }
    
    addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = addButton
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    backButton = UIBarButtonItem(image: UIImage(systemName: Const.backButtonImage), style: .plain, target: self, action: #selector(backButtonPressed))
    navigationItem.leftBarButtonItem = backButton
    navigationItem.leftBarButtonItem?.tintColor = .white
    
    searchBar?.placeholder = Const.searchBarPlaceholder
    searchBar?.delegate = self
    searchBar?.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
    searchBar?.searchTextField.backgroundColor = .white
    tableView.tableHeaderView = searchBar
    
  }
  
  @objc func addButtonPressed() {
    var textField: UITextField?
    let alert = UIAlertController(title: Const.itemAlertTitle, message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: Const.itemAlertAction, style: .default) { action in
      self.save(textField?.text ?? "")
    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = Const.itemAlertPlaceholder
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  @objc func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Data manipulation
  func save(_ title: String) {
    if let currentCategory = self.selectedCategory {
      do {
        try self.realm.write {
          let item = Item()
          item.title = title
          item.dateCreated = Date()
          currentCategory.items.append(item)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
    tableView.reloadData()
  }
  
  func delete(_ item: Item) {
    do {
      try realm.write {
        realm.delete(item)
      }
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
  }
  
  func load() {
    todoItems = selectedCategory?.items.sorted(byKeyPath: Const.itemSort, ascending: true)
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
    let cell = tableView.dequeueReusableCell(withIdentifier: Const.itemIdentifier, for: indexPath)
    if let item = todoItems?[indexPath.row] {
      cell.textLabel?.text = item.title
      cell.accessoryType = item.done ? .checkmark : .none
      if let colorHex = selectedCategory?.colorHex {
        cell.backgroundColor = UIColor(hexString: colorHex).darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count))
        cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: cell.backgroundColor, isFlat: true)
      }
    } else {
      cell.textLabel?.text = Const.itemNil
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if let item = todoItems?[indexPath.row] {
        delete(item)
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
    todoItems = todoItems?.filter(Const.searchQuery, searchBar.text!).sorted(byKeyPath: Const.searchSort, ascending: false)
    tableView.reloadData()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      load()
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }
    }
  }
}

