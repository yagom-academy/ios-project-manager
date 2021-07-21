//
//  ToDoTask+CoreDataProperties.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/21.
//
//

import Foundation
import CoreData

extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var body: String
    @NSManaged public var date: Double
    @NSManaged public var status: String
    @NSManaged public var title: String

}

extension ToDoTask: Identifiable, Task {

}
