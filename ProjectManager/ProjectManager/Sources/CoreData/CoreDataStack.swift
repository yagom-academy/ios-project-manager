//
//  CoreDataStack.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import CoreData

protocol CoreDataStack {

    var context: NSManagedObjectContext { get set }

    mutating func fetchTasks() -> [Task]
    mutating func fetchPendingTaskList() -> [PendingTaskList]
}
