//
//  AutoViewController.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation
import UIKit

class AutoViewController: UIViewController {
  @IBOutlet weak var header: UINavigationItem!
  @IBOutlet weak var manufacturerTextField: UITextField!
  @IBOutlet weak var modelTextField: UITextField!
  @IBOutlet weak var productionYearPickerView: UIDatePicker!
  @IBOutlet weak var typeOfBodyPickerView: UIPickerView!
  @IBOutlet weak var nameOfClassPickerView: UIPickerView!
  
  let typesOfBody = ["Hatchback",
                     "Sedan",
                     "SUV",
                     "Crossover",
                     "Coupe",
                     "Cabriolet"]
  
  var auto: Auto?
  
  override func viewDidLoad() {
    setTypeOfBodyPickerView()
    if let innerAuto = auto {
      header.title = "\(innerAuto.manufacturer) \(innerAuto.model)"
      manufacturerTextField.text = innerAuto.manufacturer
      modelTextField.text = innerAuto.model
      productionYearPickerView.date = Date(timeIntervalSince1970: TimeInterval(innerAuto.productionDate))
    }
  }
  
  func setTypeOfBodyPickerView() {
    
  }
}
