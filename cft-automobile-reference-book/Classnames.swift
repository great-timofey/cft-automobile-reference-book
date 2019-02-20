//
//  Classnames.swift
//  cft-automobile-reference-book
//
//  Created by user on 2/20/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//

import Foundation

enum Classnames: String, CaseIterable {
  case compact = "Compact"
  case midsize = "Midsize"
  case large = "Large"
  
  static func getIndex(ofClassname classname: String) -> Int? {
    switch classname {
    case self.compact.rawValue:
      return 0
    case self.midsize.rawValue:
      return 1
    case self.large.rawValue:
      return 2
    default:
      return nil
    }
  }
  
  static func getClassname(byIndex index: Int) -> String? {
    switch index {
    case 0:
      return self.compact.rawValue
    case 1:
      return self.midsize.rawValue
    case 2:
      return self.large.rawValue
    default:
      return nil
    }
  }
  
  static func getClassnamesCount() -> Int {
    return self.allCases.count
  }
}
