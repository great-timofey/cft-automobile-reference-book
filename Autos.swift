//
//  Autos.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation

class Autos {
  var autos: [Auto] = []
  
  func addAuto(withModel model: String,
               withManufacturer manufacturer: String,
               withBodyStyle bodyStyle: String,
               withNameOfClass nameOfClass: String,
               withProductionDate productionDate: Int) {
    let auto = Auto(model, manufacturer, bodyStyle, nameOfClass, productionDate)
    autos.append(auto)
  }
  
  func removeAuto(atIndex index: Int) {
    autos.remove(at: index)
  }
  
  func updateAuto(atIndex index: Int,
                  withParams params: [String: Any]) {
    let updatingAuto = autos[index]
    for param in params {
      let 
      updatingAuto.param
    }
  }
}
