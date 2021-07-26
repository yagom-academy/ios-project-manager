//
//  Task+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/21.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var body: String
    @NSManaged public var date: Double
    @NSManaged public var status: String
    @NSManaged public var title: String

}

extension Task: Identifiable {

}
