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
  @IBOutlet weak var saveButtonItem: UIBarButtonItem!
  
  var passedAuto: Auto?
  
  var chosenTypeOfBody: String {
    return BodyStyles.getBodyStyle(byIndex: typeOfBodyPickerView.selectedRow(inComponent: 0))!
  }
  var chosenClassname: String {
    return Classnames.getClassname(byIndex: nameOfClassPickerView.selectedRow(inComponent: 0))!
  }
  var chosenProductionDate: Date {
    return productionDatePickerView.date
  }
  
  override func viewDidLoad() {
    self.typeOfBodyPickerView.delegate = self
    self.typeOfBodyPickerView.dataSource = self
    self.nameOfClassPickerView.delegate = self
    self.nameOfClassPickerView.dataSource = self
    saveButtonItem.action = #selector(save)
    saveButtonItem.target = self
    
    if let passedAuto = passedAuto {
      header.title = "\(passedAuto.manufacturer!) \(passedAuto.model!)"
      manufacturerTextField.text = passedAuto.manufacturer
      modelTextField.text = passedAuto.model
      productionDatePickerView.date = passedAuto.productionDate! as Date
      typeOfBodyPickerView.selectRow(BodyStyles.getIndex(ofBodyStyle: passedAuto.bodyStyle!)!,
                                     inComponent: 0,
                                     animated: false)
      nameOfClassPickerView.selectRow(Classnames.getIndex(ofClassname: passedAuto.classname!)!,
                                      inComponent: 0,
                                      animated: false)
    } else {
      header.title = "Add New Auto"
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return pickerView == typeOfBodyPickerView ?
      BodyStyles.getBodyStylesCount() :
      Classnames.getClassnamesCount()
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String? {
    return pickerView == typeOfBodyPickerView ?
      BodyStyles.getBodyStyle(byIndex: row) :
      Classnames.getClassname(byIndex: row)
  }
  
  @objc func save() {
    let model = modelTextField.text!
    let manufacturer = manufacturerTextField.text!
    if !model.isEmpty, !manufacturer.isEmpty {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      let car = passedAuto ?? Auto(context: managedContext)
      car.model = model
      car.manufacturer = manufacturer
      car.bodyStyle = chosenTypeOfBody
      car.classname = chosenClassname
      car.productionDate = chosenProductionDate as NSDate
      
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
      navigationController?.popViewController(animated: true)
    } else {
      let alertController = UIAlertController(title: "Save Error", message:
        "You haven't filled necessary fields for creating auto", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Back", style: .default))
      self.present(alertController, animated: true, completion: nil)
    }
  }
  
}
