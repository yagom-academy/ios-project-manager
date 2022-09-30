//
//  CoreMataManagerInterface.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/22.
//

import CoreData
import CloudKit

class CoreDataManager: CoreDataManagerInterface {
    
    //MARK: - Properties
    
    private var _privatePersistentStore: NSPersistentStore?
    private var _sharedPersistentStore: NSPersistentStore?
    
    var privatePersistentStore: NSPersistentStore {
        guard let privateStore = _privatePersistentStore else {
            fatalError("Private store is not set")
        }
        return privateStore
    }
    
    var sharedPersistentStore: NSPersistentStore {
        guard let sharedStore = _sharedPersistentStore else {
            fatalError("Shared store is not set")
        }
        return sharedStore
    }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "ProjectTask")
        
        guard let privateStoreDescription = container.persistentStoreDescriptions.first else {
            fatalError("Unable to get persistentStoreDescription")
        }
        
        let storesURL = privateStoreDescription.url?.deletingLastPathComponent()
        privateStoreDescription.url = storesURL?.appendingPathComponent("private.sqlite")
        let sharedStoreURL = storesURL?.appendingPathComponent("shared.sqlite")
        guard let sharedStoreDescription = privateStoreDescription.copy() as? NSPersistentStoreDescription else {
            fatalError("Copying the private store description returned an unexpected value.")
        }
        sharedStoreDescription.url = sharedStoreURL
        
        guard let containerIdentifier = privateStoreDescription.cloudKitContainerOptions?.containerIdentifier else {
            fatalError("Unable to get containerIdentifier")
        }
        let sharedStoreOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: containerIdentifier)
        sharedStoreOptions.databaseScope = .shared
        sharedStoreDescription.cloudKitContainerOptions = sharedStoreOptions
        container.persistentStoreDescriptions.append(sharedStoreDescription)
        
        container.loadPersistentStores { loadedStoreDescription, error in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error)")
            } else if let cloudKitContainerOptions = loadedStoreDescription.cloudKitContainerOptions {
                guard let loadedStoreDescritionURL = loadedStoreDescription.url else {
                    return
                }
                
                if cloudKitContainerOptions.databaseScope == .private {
                    let privateStore = container.persistentStoreCoordinator.persistentStore(for: loadedStoreDescritionURL)
                    self._privatePersistentStore = privateStore
                } else if cloudKitContainerOptions.databaseScope == .shared {
                    let sharedStore = container.persistentStoreCoordinator.persistentStore(for: loadedStoreDescritionURL)
                    self._sharedPersistentStore = sharedStore
                }
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        do {
            try container.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("Failed to pin viewContext to the current generation: \(error)")
        }
        
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    //MARK: - Data Handling Method
    
    func fetchAllTaskList() -> [ProjectTask] {
        do {
            let taskEntities = try context.fetch(TaskEntity.fetchRequest())
            var taskLists: [ProjectTask] = []
            
            taskEntities.forEach { taskEntity in
                guard let task = transformToProjectTask(from: taskEntity) else {
                    return
                }
                taskLists.append(task)
            }
            return taskLists
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetchTaskList(state: ProjectTaskState) -> [ProjectTask] {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        request.predicate = NSPredicate(format: "state = %@", state.rawValue)
        
        do {
            let taskEntities = try context.fetch(request)
            var taskLists: [ProjectTask] = []
            
            taskEntities.forEach { taskEntity in
                guard let task = transformToProjectTask(from: taskEntity) else {
                    return
                }
                taskLists.append(task)
            }
            return taskLists
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveCurrentTaskList() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveTask(projectTask: ProjectTask, state: ProjectTaskState) {
        do {
            let taskEntity = TaskEntity(context: context)
            taskEntity.id = projectTask.id
            taskEntity.title = projectTask.title
            taskEntity.desc = projectTask.description
            taskEntity.date  = projectTask.date
            taskEntity.state = state.rawValue
            
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func updateTask(projectTask: ProjectTask, state: ProjectTaskState) {
        let taskEntityUUID = projectTask.id
        
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        request.predicate = NSPredicate(format: "id = %@", taskEntityUUID as CVarArg)
        
        do {
            let taskEntities = try context.fetch(request)
            let taskEntity = taskEntities[0]
            taskEntity.setValue(projectTask.title, forKey: "title")
            taskEntity.setValue(projectTask.description, forKey: "desc")
            taskEntity.setValue(projectTask.date, forKey: "date")
            taskEntity.setValue(state.rawValue, forKey: "state")
            
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved update error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deleteTask(id: UUID) {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let taskEntities = try context.fetch(request)
            let taskEntity = taskEntities[0]
            context.delete(taskEntity)
            
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error delete\(nserror), \(nserror.userInfo)")
        }
    }
}

private extension CoreDataManager {
    func transformToProjectTask(from taskEntity: TaskEntity) -> ProjectTask? {
        guard let id = taskEntity.id,
              let title = taskEntity.title,
              let description = taskEntity.desc,
              let date = taskEntity.date
        else {
            debugPrint("\(#function) is failed - optional binding failed ")
            return nil
        }
        
        return ProjectTask(
            id: id,
            title: title,
            description: description,
            date: date
        )
    }
}
