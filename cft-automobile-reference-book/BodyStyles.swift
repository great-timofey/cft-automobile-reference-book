//
//  BodyStyles.swift
//  cft-automobile-reference-book
//
//  Created by user on 2/20/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation

enum BodyStyles: String, CaseIterable {
  case hatchback = "Hatchback"
  case sedan = "Sedan"
  case suv = "SUV"
  case crossover = "Crossover"
  case coupe = "Coupe"
  case cabriolet = "Cabriolet"
  
  static func getIndex(ofBodyStyle bodyStyle: String) -> Int? {
    switch bodyStyle {
    case self.hatchback.rawValue:
      return 0
    case self.sedan.rawValue:
      return 1
    case self.suv.rawValue:
      return 2
    case self.crossover.rawValue:
      return 3
    case self.coupe.rawValue:
      return 4
    case self.cabriolet.rawValue:
      return 5
    default:
      return nil
    }
  }
  
  static func getBodyStyle(byIndex index: Int) -> String? {
    switch index {
    case 0:
      return self.hatchback.rawValue
    case 1:
      return self.sedan.rawValue
    case 2:
      return self.suv.rawValue
    case 3:
      return self.crossover.rawValue
    case 4:
      return self.coupe.rawValue
    case 5:
      return self.cabriolet.rawValue
    default:
      return nil
    }
  }
  
  static func getBodyStylesCount() -> Int {
    return self.allCases.count
  }
}
