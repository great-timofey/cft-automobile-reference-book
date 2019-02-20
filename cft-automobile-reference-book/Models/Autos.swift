//
//  Autos.swift
//  cft-automobile-reference-book
//
//  Created by Тимофей Твердохлебов on 2/15/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation

class Autos {
  var cars: [Car] = []
  var length: Int {
    get {
      return cars.count
    }
  }
  
  init() {
    addCar(withModel: "911",
            withManufacturer: "Porshe",
            withBodyStyle: "Cabriolet",
            withNameOfClass: "Compact",
            withProductionDate: Date())
  }
  
  func getCar(atIndex index: Int) -> Car? {
    assert(index < cars.count, "You're trying to get auto at unexisted index")
    return cars[index]
  }
  
  func addCar(withModel model: String,
               withManufacturer manufacturer: String,
               withBodyStyle bodyStyle: String,
               withNameOfClass nameOfClass: String,
               withProductionDate productionDate: Date) {
    let car = Car(model, manufacturer, bodyStyle, nameOfClass, productionDate)
    cars.append(car)
  }
  
  func removeCar(atIndex index: Int) {
    cars.remove(at: index)
  }
  
  func updateCar(atIndex index: Int,
                  withParams params: [String: Any]) {
    assert(index < cars.count, "You're trying to update auto at unexisted index")
    let updatingCar = cars[index]
    for param in params {
      let (key, value) = param
      updatingCar.setProperty(withName: key, withValue: value)
    }
  }
}
