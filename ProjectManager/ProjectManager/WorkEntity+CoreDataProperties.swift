//
//  WorkEntity+CoreDataProperties.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/23.
//
//

import Foundation
import CoreData

extension WorkEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkEntity> {
        return NSFetchRequest<WorkEntity>(entityName: "WorkEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var deadline: Date
    @NSManaged public var state: String

}

extension WorkEntity: Identifiable {

}
