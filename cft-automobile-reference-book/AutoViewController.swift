//
//  AutoViewController.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation
import UIKit

class AutoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet weak var header: UINavigationItem!
  @IBOutlet weak var manufacturerTextField: UITextField!
  @IBOutlet weak var modelTextField: UITextField!
  @IBOutlet weak var productionYearPickerView: UIDatePicker!
  @IBOutlet weak var typeOfBodyPickerView: UIPickerView!
  @IBOutlet weak var nameOfClassPickerView: UIPickerView!
  @IBOutlet weak var rightBarButton: UIBarButtonItem!
  
  let typesOfBody = ["Hatchback",
                     "Sedan",
                     "SUV",
                     "Crossover",
                     "Coupe",
                     "Cabriolet"]
  
  let namesOfClass = ["Compact",
                     "Midsize",
                     "Large"]
  
  var auto: Auto?
  
  override func viewDidLoad() {
    self.typeOfBodyPickerView.delegate = self
    self.typeOfBodyPickerView.dataSource = self
    self.nameOfClassPickerView.delegate = self
    self.nameOfClassPickerView.dataSource = self
    
    if let innerAuto = auto {
      header.title = "\(innerAuto.manufacturer) \(innerAuto.model)"
      manufacturerTextField.text = innerAuto.manufacturer
      modelTextField.text = innerAuto.model
      productionYearPickerView.date = Date(timeIntervalSince1970: TimeInterval(innerAuto.productionDate))
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerView == typeOfBodyPickerView ? typesOfBody.count : namesOfClass.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerView == typeOfBodyPickerView ? typesOfBody[row] : namesOfClass[row]
  }
  
}
