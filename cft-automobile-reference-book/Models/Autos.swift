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
  var length: Int {
    get {
      return autos.count
    }
  }
  
  init() {
    addAuto(withModel: "911",
            withManufacturer: "Porshe",
            withBodyStyle: "Cabriolet",
            withNameOfClass: "Compact",
            withProductionDate: Date())
  }
  
  func getAuto(atIndex index: Int) -> Auto? {
    assert(index < autos.count, "You're trying to get auto at unexisted index")
    return autos[index]
  }
  
  func addAuto(withModel model: String,
               withManufacturer manufacturer: String,
               withBodyStyle bodyStyle: String,
               withNameOfClass nameOfClass: String,
               withProductionDate productionDate: Date) {
    let auto = Auto(model, manufacturer, bodyStyle, nameOfClass, productionDate)
    autos.append(auto)
  }
  
  func removeAuto(atIndex index: Int) {
    autos.remove(at: index)
  }
  
  func updateAuto(atIndex index: Int,
                  withParams params: [String: Any]) {
    assert(index < autos.count, "You're trying to update auto at unexisted index")
    let updatingAuto = autos[index]
    for param in params {
      let (key, value) = param
      updatingAuto.setProperty(withName: key, withValue: value)
    }
  }
}
