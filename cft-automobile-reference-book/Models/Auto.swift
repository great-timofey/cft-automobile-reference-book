//
//  Auto.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation

class Auto {
  var id: UUID
  var model: String
  var manufacturer: String
  var bodyStyle: String
  var nameOfClass: String
  var productionDate: Date
  
  init(_ model: String,
       _ manufacturer: String,
       _ bodyStyle: String,
       _ nameOfClass: String,
       _ productionDate: Date) {
    
    self.id = UUID()
    self.model = model
    self.manufacturer = manufacturer
    self.bodyStyle = bodyStyle
    self.nameOfClass = nameOfClass
    self.productionDate = productionDate
  }
  
  func setProperty(withName propertyName: String, withValue value: Any) {
    switch propertyName {
    case "model":
      setModel(value as! String)
    case "manufacturer":
      setManufacturer(value as! String)
    case "nameOfClass":
      setNameOfClass(value as! String)
    case "bodyStyle":
      setBodyStyle(value as! String)
    case "productionDate":
      setProductionDate(value as! Date)
    default:
      return
    }
  }
  
  private func setModel(_ model: String) {
    self.model = model
  }
  
  private func setManufacturer(_ manufacturer: String) {
    self.manufacturer = manufacturer
  }
  
  private func setBodyStyle(_ bodyStyle: String) {
    self.bodyStyle = bodyStyle
  }
  
  private func setNameOfClass(_ nameOfClass: String) {
    self.nameOfClass = nameOfClass
  }
  
  private func setProductionDate(_ productionDate: Date) {
    self.productionDate = productionDate
  }
}
