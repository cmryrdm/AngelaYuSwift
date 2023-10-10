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
  
  var itemArray = [Item]()
  let appearance = UINavigationBarAppearance()
  var barButton: UIBarButtonItem?
  var searchBar: UISearchBar?
  //let defaults = UserDefaults.standard // UserDefaults
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") // Codable
  // recommended to implementation for iOS 16.0 > appending(path: "Items.plist", directoryHint: .inferFromPath)
  //Core Data
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  static func instantiate() -> TodoListViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = TodoListViewController(style: .plain)
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoItemCell")
    
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBlue
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    navigationItem.rightBarButtonItem = barButton
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    searchBar = UISearchBar()
    searchBar?.placeholder = "Search"
    searchBar?.delegate = self
    searchBar?.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
    
    tableView.tableHeaderView = searchBar
    
    loadItems()
    
    // Data persistence with UserDefaults loads entire plist for just one data! Do not use this as database.
//    if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//      itemArray = items
//    }
  }
  
  @objc func addButtonPressed() {
    var textField: UITextField?
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { action in
      
      
      let item = Item(context: self.context)
      item.title = textField?.text ?? ""
      item.done = false
      self.itemArray.append(item)
      
      //self.defaults.set(self.itemArray, forKey: "TodoListArray")
      self.saveItems()
    }
    
    alert.addTextField { alertTextField in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  func saveItems() {
    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
    self.tableView.reloadData() // to show the new item on the tableView
    //    // Codable
    //    let encoder = PropertyListEncoder()
    //    do {
    //      let data = try encoder.encode(self.itemArray)
    //      try data.write(to: self.dataFilePath!)
    //    } catch {
    //      print(error.localizedDescription)
    //    }
  }
  
  // if no value passed Item.fetchRequest() called!
  func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
    do {
      itemArray = try context.fetch(request)
    } catch {
      print(error.localizedDescription)
    }
    tableView.reloadData()
//    // Codable
//    if let data = try? Data(contentsOf: dataFilePath!) {
//      let decoder = PropertyListDecoder()
//      do {
//        itemArray = try decoder.decode([Item].self, from: data)
//      } catch {
//        print(error.localizedDescription)
//      }
//    }
    
  }
  
  
  //MARK: - Tableview datasource methods
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
  
  //MARK: - Tableview delegate methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    //update title
//    itemArray[indexPath.row].setValue("completed", forKey: "title")
    
//    // delete > you need to remove from DB first as indexpath.row is used in context!
//    context.delete(itemArray[indexPath.row])
//    itemArray.remove(at: indexPath.row)
    
    // update done
    let item = itemArray[indexPath.row]
    item.done = !item.done
    
    saveItems()
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

//MARK: - SearchBar delegate methods
extension TodoListViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    // c: case & d: diacritic insensitivity
    request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    loadItems(with: request)
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

////Required for codable
//class Item: Codable {
//  var title: String = ""
//  var done: Bool = false
//}


