//
//  TaskEntity+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/23.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var state: String?
    @NSManaged public var title: String?

}

extension TaskEntity : Identifiable {

}
