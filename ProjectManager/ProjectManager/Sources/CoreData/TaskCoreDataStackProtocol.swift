//
//  TaskCoreDataStackProtocol.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import CoreData

protocol TaskCoreDataStackProtocol {

    var context: NSManagedObjectContext { get set }

    mutating func saveContext()
    mutating func fetchTasks() -> [Task]
    mutating func fetchPendingTaskList() -> [PendingTaskList]
}
