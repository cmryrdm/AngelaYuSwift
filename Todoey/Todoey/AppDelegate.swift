//
//  AppDelegate.swift
//  Todoey
//
//  Created by CEMRE YARDIM on 2.10.2023.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let categoryViewController = CategoryViewController.instantiate()
    let navigationController = UINavigationController(rootViewController: categoryViewController)
    // for SwiftUI assign hostingController <<<<<<<<<<<<<<<< !!!
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    // user defaults save data to plist in a sandbox (id) of a simulator (id)
    //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    
    do {
      let realm = try Realm()
    } catch {
      print(error.localizedDescription)
    }
    
    return true
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    self.saveContext()
  }
  
  // MARK: UISceneSession Lifecycle
  //  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
  //    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  //  }
  //
  //  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  //  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "DataModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}

