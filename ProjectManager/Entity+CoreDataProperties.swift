//
//  Entity+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 박종화 on 2023/09/26.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var duration: Date?
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var status: String?

}

extension Entity : Identifiable {

}
