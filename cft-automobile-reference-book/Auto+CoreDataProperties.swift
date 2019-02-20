//
//  Auto+CoreDataProperties.swift
//  cft-automobile-reference-book
//
//  Created by user on 2/20/19.
//  Copyright © 2019 Тимофей Твердохлебов. All rights reserved.
//
//

import Foundation
import CoreData


extension Auto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Auto> {
        return NSFetchRequest<Auto>(entityName: "Auto")
    }

    @NSManaged public var bodyStyle: String?
    @NSManaged public var id: UUID?
    @NSManaged public var manufacturer: String?
    @NSManaged public var model: String?
    @NSManaged public var classname: String?
    @NSManaged public var productionDate: NSDate?

}
