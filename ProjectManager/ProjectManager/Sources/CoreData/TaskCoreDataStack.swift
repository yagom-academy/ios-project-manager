//
//  TaskCoreDataStack.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/29.
//

import CoreData

struct TaskCoreDataStack: CoreDataStack {

    static let persistentContainerName = "ProjectManager"
    static let shared = TaskCoreDataStack()

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: TaskCoreDataStack.persistentContainerName)
        container.loadPersistentStores { (_, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            if let error = error {
                fatalError("Persistent store 로드에 실패했어요. \(error)")
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
