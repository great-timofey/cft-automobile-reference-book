//
//  AutoViewController.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AutoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet weak var header: UINavigationItem!
  @IBOutlet weak var manufacturerTextField: UITextField!
  @IBOutlet weak var modelTextField: UITextField!
  @IBOutlet weak var productionDatePickerView: UIDatePicker!
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
  
  var auto: Car?
  
  var chosenTypeOfBody: String {
    return typesOfBody[typeOfBodyPickerView.selectedRow(inComponent: 0)]
  }
  var chosenNameOfClass: String {
    return namesOfClass[nameOfClassPickerView.selectedRow(inComponent: 0)]
  }
  var chosenProductionDate: Date {
    return productionDatePickerView.date
  }
  
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
    if let modelText = modelTextField.text,
      let manufacturerText = manufacturerTextField.text {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      let entity =
        NSEntityDescription.entity(forEntityName: "Auto",
                                   in: managedContext)!
      
      let car = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      let id = UUID()
      car.setValue(modelText, forKeyPath: "model")
      car.setValue(id, forKeyPath: "id")
      car.setValue(manufacturerText, forKeyPath: "manufacturer")
      car.setValue(chosenTypeOfBody, forKeyPath: "body_style")
      car.setValue(chosenNameOfClass, forKeyPath: "name_of_class")
      car.setValue(chosenProductionDate, forKeyPath: "production_date")
      
      do {
        managedContext.insert(car)
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
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
