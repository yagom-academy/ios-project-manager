//
//  CoreMataManagerInterface.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/22.
//

import CoreData

class CoreDataManager: CoreDataManagerInterface {
    
    //MARK: - Properties
    
    //    private lazy var persistentContainer: NSPersistentContainer = {
    //        let container = NSPersistentContainer(name: "ProjectTask")
    //        container.loadPersistentStores { description, error in
    //            if let error = error {
    //                fatalError("Unable to load persistent stores: \(error)")
    //            }
    //        }
    //        return container
    //    }()
    
    private lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "ProjectTask")
        //        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        //            if let error = error as NSError? {
        //                fatalError("Unresolved error \(error), \(error.userInfo)")
        //            }
        //        })
        
//        let localStoreLocation = URL(fileURLWithPath: "/path/to/local.store")
//        let localStoreDescription = NSPersistentStoreDescription(url: localStoreLocation)
//        localStoreDescription.configuration = "Local"
//        
//        let cloudStoreLocation = URL(fileURLWithPath: "/path/to/cloud.store")
//        let cloudStoreDescription = NSPersistentStoreDescription(url: cloudStoreLocation)
//        cloudStoreDescription.configuration = "Cloud"
//        
//        cloudStoreDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "net.borysarang.ProjectManager")
//        
//        container.persistentStoreDescriptions = [
//            localStoreDescription,
//            cloudStoreDescription
//        ]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
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
