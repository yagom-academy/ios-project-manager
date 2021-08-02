//
//  TaskBuffer+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/08/02.
//
//

import Foundation
import CoreData


extension TaskBuffer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskBuffer> {
        return NSFetchRequest<TaskBuffer>(entityName: "TaskBuffer")
    }

    @NSManaged public var httpMethod: String?
    @NSManaged public var title: String?
    @NSManaged public var status: String?
    @NSManaged public var deadline: Double
    @NSManaged public var id: String?
    @NSManaged public var detail: String?

}

extension TaskBuffer : Identifiable {

}
