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
    @NSManaged public var isRemoved: Bool

    var isExpired: Bool? {
        guard let currentDate = Date().date else { return nil }
        return dueDate < currentDate
    }

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
