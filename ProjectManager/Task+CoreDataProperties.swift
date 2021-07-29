//
//  Task+CoreDataProperties.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/29.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: Task.entityName)
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var dueDate: Date
    @NSManaged public var state: String

    var taskState: State {
        get {
            return State(rawValue: state) ?? .todo
        }

        set {
            self.state = newValue.rawValue
        }
    }
}

extension Task: Identifiable { }
