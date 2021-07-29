//
//  Task+CoreDataClass.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/29.
//
//

import Foundation
import CoreData

@objc(Task)
public final class Task: NSManagedObject {

    static let entityName = "Task"

    enum State: String, Codable {
        case todo, doing, done
    }
}
