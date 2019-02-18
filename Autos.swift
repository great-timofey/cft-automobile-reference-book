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
    addAuto(withModel: "911", withManufacturer: "Porshe", withBodyStyle: "Cupe", withNameOfClass: "Race Car", withProductionDate: 1990)
    updateAuto(atIndex: 0, withParams: ["model": "10"])
  }
  
  func getAuto(atIndex index: Int) -> Auto? {
    assert(index < autos.count, "You're trying to get auto at unexisted index")
    return autos[index]
  }
  
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
    var updatingAuto = autos[index]
    for param in params {
      let (key, value) = param
      updatingAuto.key = value
      //print("\(key) : \(value)")
    }
  }
}
