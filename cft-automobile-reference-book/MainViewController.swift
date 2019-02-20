//
//  ViewController.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  @IBOutlet weak var autosTableView: UITableView!
  
  let fetchController: NSFetchedResultsController<NSManagedObject>? = {
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return nil
    }
    
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    let fetchRequest =
      NSFetchRequest<NSManagedObject>(entityName: "Auto")
    
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "manufacturer", ascending: true)]
    
    let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                managedObjectContext: managedContext,
                                                sectionNameKeyPath: nil,
                                                cacheName: nil)
    
    return controller
  }()
  
  let cellReuseIdentifier = "AutoCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchController!.delegate = self
    autosTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    
    do {
      try fetchController!.performFetch()
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      do {
        let auto = fetchController!.object(at: indexPath) as! Auto
        managedContext.delete(auto)
        try managedContext.save()
      } catch let error {
        print(error)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = fetchController!.sections {
      return sections[section].numberOfObjects
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = autosTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    let auto = fetchController!.object(at: indexPath) as! Auto
    cell.textLabel?.text = getNameForCell(withAuto: auto)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = autosTableView.cellForRow(at: indexPath)
    cell?.isSelected = false
    performSegue(withIdentifier: "showAuto", sender: cell)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showAuto" {
      let cell = sender as! UITableViewCell
      if let vc = segue.destination as? AutoViewController,
        let indexPath = autosTableView.indexPath(for: cell) {
        let auto = fetchController!.object(at: indexPath) as! Auto
        vc.passedAuto = auto
      }
    }
  }
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChange anObject: Any,
                  at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType,
                  newIndexPath: IndexPath?) {
    
    switch type {
    case .insert:
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .automatic)
      }
    case .update:
      if let indexPath = indexPath {
        let auto = fetchController!.object(at: indexPath) as! Auto
        let cell = tableView.cellForRow(at: indexPath)
        cell!.textLabel?.text = getNameForCell(withAuto: auto)
      }
    case .move:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
      if let newIndexPath = newIndexPath {
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    default:
      return
    }
    
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func getNameForCell(withAuto auto: Auto) -> String {
    return "\(auto.manufacturer!) \(auto.model!)"
  }
  
}

