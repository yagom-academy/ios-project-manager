//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by 양호준 on 2022/03/22.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var category: Int64

}
