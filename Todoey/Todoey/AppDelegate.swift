//
//  AppDelegate.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 2.10.2023.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let categoryViewController = CategoryViewController.instantiate()
    let navigationController = UINavigationController(rootViewController: categoryViewController)
    navigationController.navigationBar.prefersLargeTitles = true
    // for SwiftUI assign hostingController <<<<<<<<<<<<<<<< !!!
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    // user defaults save data to plist in a sandbox (id) of a simulator (id)
    //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    
    //print(Realm.Configuration.defaultConfiguration.fileURL)
//    do {
//      _ = try Realm()
//    } catch {
//      print(error.localizedDescription)
//    }
    return true
  }
}

