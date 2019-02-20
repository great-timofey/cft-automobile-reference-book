//
//  AppDelegate.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let context = persistentContainer.viewContext
    let firstItemProductionDate = "2008-02-02"
    let secondItemProductionDate = "2002-02-02"
    let thirdItemProductionDate = "1992-02-02"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    
    let firstItem = Auto(context: context)
    firstItem.model = "A8"
    firstItem.manufacturer = "Audi"
    firstItem.bodyStyle = BodyStyles.coupe.rawValue
    firstItem.classname = Classnames.large.rawValue
    firstItem.productionDate = dateFormatter.date(from: firstItemProductionDate)! as NSDate
    
    let secondItem = Auto(context: context)
    secondItem.model = "M3"
    secondItem.manufacturer = "BMW"
    secondItem.bodyStyle = BodyStyles.sedan.rawValue
    secondItem.classname = Classnames.compact.rawValue
    secondItem.productionDate = dateFormatter.date(from: secondItemProductionDate)! as NSDate
    
    let thirdItem = Auto(context: context)
    thirdItem.model = "AMG 30"
    thirdItem.manufacturer = "Mercedes"
    thirdItem.bodyStyle = BodyStyles.hatchback.rawValue
    thirdItem.classname = Classnames.midsize.rawValue
    thirdItem.productionDate = dateFormatter.date(from: thirdItemProductionDate)! as NSDate
    
    saveContext()
    
    return true
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    self.saveContext()
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "cft_automobile_reference_book")
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
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
}

