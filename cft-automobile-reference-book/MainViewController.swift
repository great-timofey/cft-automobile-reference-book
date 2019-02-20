//
//  ViewController.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {
  @IBOutlet weak var autosTableView: UITableView!
  
  private var cars: [NSManagedObject] = []
  
  let cellReuseIdentifier = "AutoCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    autosTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("appear")
    
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    let fetchRequest =
      NSFetchRequest<NSManagedObject>(entityName: "Auto")
    
    do {
      print(1)
      cars = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cars.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = autosTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    let car = cars[indexPath.row]
    let model = car.value(forKeyPath: "model") as! String
    let manufacturer = car.value(forKeyPath: "manufacturer") as! String
    cell.textLabel?.text = "\(manufacturer) \(model)"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = autosTableView.cellForRow(at: indexPath)
    cell?.isSelected = false
    performSegue(withIdentifier: "showAuto", sender: cell)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showAuto":
      let cell = sender as! UITableViewCell
      if let vc = segue.destination as? AutoViewController, let index = autosTableView.indexPath(for: cell) {
//        vc.auto = autos.getCar(atIndex: index.row)!
      }
    case "createAuto":
      if let vc = segue.destination as? AutoViewController {
        vc.header.title = "Add New Auto"
      }
    default:
      break
    }
  }
  
}

