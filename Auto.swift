//
//  Auto.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation

@dynamicMemberLookup
class Auto {
  var id: UUID
  var model: String
  var manufacturer: String
  var bodyStyle: String
  var nameOfClass: String
  var productionDate: Int
  
  init(_ model: String,
       _ manufacturer: String,
       _ bodyStyle: String,
       _ nameOfClass: String,
       _ productionDate: Int) {
    
    self.id = UUID()
    self.model = model
    self.manufacturer = manufacturer
    self.bodyStyle = bodyStyle
    self.nameOfClass = nameOfClass
    self.productionDate = productionDate
  }
  
  subscript(dynamicMember member: String) -> Any? {
    get {
      let properties: [String: Any] = [
        "id": id,
        "model": model,
        "manufacturer": manufacturer,
        "bodyStyle": bodyStyle,
        "nameOfClass": nameOfClass,
        "productionDate": productionDate
      ]
      return properties[member, default: ""]
    }
    set {
      if let value = newValue {
        print("trying to change - \(member) : \(value)")
        updateProperty(withName: member, withValue: value)
      }
    }
  }
  
  func updateProperty(withName propertyName: String, withValue value: Any) {
    self.propertyName = value
  }
  
}
