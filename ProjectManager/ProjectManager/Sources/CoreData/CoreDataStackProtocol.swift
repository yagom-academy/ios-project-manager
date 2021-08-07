//
//  CoreDataStackProtocol.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import CoreData

protocol CoreDataStackProtocol {

    var context: NSManagedObjectContext { get set }

    mutating func saveContext()
    mutating func fetchTasks() -> [Task]
    mutating func fetchPendingTaskList() -> [PendingTaskList]
    func count(of entity: String) -> Int?
}
