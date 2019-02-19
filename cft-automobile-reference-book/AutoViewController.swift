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
  @IBOutlet weak var productionDatePickerView: UIDatePicker!
  @IBOutlet weak var typeOfBodyPickerView: UIPickerView!
  @IBOutlet weak var nameOfClassPickerView: UIPickerView!
  @IBOutlet weak var rightBarButton: UIBarButtonItem!
  
  var chosenTypeOfBody: String?
  var chosenNameOfClass: String?
  var chosenProductionDate: Date?
  
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
    setRightBarButton()
    
    if let innerAuto = auto {
      header.title = "\(innerAuto.manufacturer) \(innerAuto.model)"
      manufacturerTextField.text = innerAuto.manufacturer
      modelTextField.text = innerAuto.model
      productionDatePickerView.date = innerAuto.productionDate
      typeOfBodyPickerView.selectRow(typesOfBody.lastIndex(of: innerAuto.bodyStyle)!, inComponent: 0, animated: false)
      nameOfClassPickerView.selectRow(namesOfClass.lastIndex(of: innerAuto.nameOfClass)!, inComponent: 0, animated: false)
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return pickerView == typeOfBodyPickerView ? typesOfBody.count : namesOfClass.count
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String? {
    return pickerView == typeOfBodyPickerView ? typesOfBody[row] : namesOfClass[row]
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow row: Int,
                  inComponent component: Int) {
    if pickerView == typeOfBodyPickerView {
      chosenTypeOfBody = typesOfBody[row]
    } else if pickerView == nameOfClassPickerView {
      chosenNameOfClass = namesOfClass[row]
    }
  }
  
  
  
  func setRightBarButton() {
    rightBarButton.target = self
    if auto != nil {
      rightBarButton.title = "Delete"
      rightBarButton.tintColor = UIColor.red
      rightBarButton.action = #selector(onSaveAuto)
    } else {
      rightBarButton.title = "Save"
      rightBarButton.action = #selector(onSaveAuto)
    }
  }
  
  @objc func onSaveAuto() {
    if let innerAuto = auto,
      let modelText = modelTextField.text,
      let manufacturerText = manufacturerTextField.text,
      chosenTypeOfBody != nil,
      chosenNameOfClass != nil {
      innerAuto.bodyStyle = chosenTypeOfBody!
      innerAuto.nameOfClass = chosenNameOfClass!
      innerAuto.productionDate = productionDatePickerView.date
      innerAuto.model = modelText
      innerAuto.manufacturer = manufacturerText
      navigationController?.popViewController(animated: true)
    } else {
      let alertController = UIAlertController(title: "Error", message:
        "You haven't filled necessary fields for creating auto. Please, fill all the fields", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Back", style: .default))
      self.present(alertController, animated: true, completion: nil)
    }
  }
  
  @objc func onDeleteAuto() {
    print("on delete auto")
  }
  
}
