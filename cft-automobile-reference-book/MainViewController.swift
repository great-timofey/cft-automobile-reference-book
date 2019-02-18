//
//  ViewController.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
  @IBOutlet weak var autosTableView: UITableView!
  
  private var autos = Autos()
  
  let cellReuseIdentifier = "AutoCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    autosTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return autos.length
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = autosTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    if let auto = autos.getAuto(atIndex: indexPath.row) {
      cell.textLabel?.text = auto.model as String
    }
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
      if let vc = segue.destination as? AutoViewController {
        vc.header.title = cell.textLabel?.text
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

