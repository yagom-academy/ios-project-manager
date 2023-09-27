//
//  CoreDataManager.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/27.
//

import CoreData

final class CoreDataManager {
    private var todoList = [TODO]()
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchTODO() -> [TODO] {
        let request: NSFetchRequest<TODO> = TODO.fetchRequest()
        let sortByDate = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDate]
        
        do {
            let todos = try mainContext.fetch(request)
            return todos
        } catch {
            fatalError()
        }
    }
    
    func createTODO() -> [TODO] {
        let newTODO = TODO(context: mainContext)
        newTODO.id = UUID()
        newTODO.date = Date()
        
        return [newTODO]
    }
    
    func deletTODO(_ todo: TODO?) {
        guard let todo = todo else {
            return
        }
        mainContext.delete(todo)
        saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TODO")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
