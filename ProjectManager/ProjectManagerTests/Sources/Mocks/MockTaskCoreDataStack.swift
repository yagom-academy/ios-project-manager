//
//  MockTaskCoreDataStack.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import CoreData
@testable import ProjectManager

struct MockTaskCoreDataStack: CoreDataStack {

    static let persistentContainerName = "ProjectManager"

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: TaskCoreDataStack.persistentContainerName)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)

            if let error = error {
                fatalError("\(error)")
            }
        }
        return container
    }()
    var context: NSManagedObjectContext

    private init() {
        context = persistentContainer.viewContext
    }

    mutating func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                let error = error as NSError
                print(error)
            }
        }
    }

    mutating func fetchTasks() -> [Task] {
        let fetchRequest = NSFetchRequest<Task>(entityName: Task.entityName)

        do {
            let tasks = try persistentContainer.viewContext.fetch(fetchRequest)
            return tasks
        } catch let error {
            print(error)
            return []
        }
    }

    mutating func fetchPendingTaskList() -> [PendingTaskList] {
        let fetchRequest = NSFetchRequest<PendingTaskList>(entityName: PendingTaskList.entityName)

        do {
            let pendingTaskList = try persistentContainer.viewContext.fetch(fetchRequest)
            return pendingTaskList
        } catch let error {
            print(error)
            return []
        }
    }
}
