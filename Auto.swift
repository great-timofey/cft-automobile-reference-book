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
}
