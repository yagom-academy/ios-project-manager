//
//  DataManager.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/30.
//

import CoreData

final class DataManager {
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDo")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = persistentContainer.viewContext
    }
    
    func createToDo(title: String? = "", deadline: Date? = Date(), body: String? = "", category: Category) -> ToDo {
        let todo = ToDo(context: viewContext)
        todo.title = title
        todo.deadline = deadline
        todo.body = body
        todo.category = category.rawValue
        
        return todo
    }
    
    func fetchToDoList() -> [ToDo] {
        do {
            let fetchRequest = ToDo.fetchRequest()
            
            return try viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            
            return []
        }
    }
    
    func saveContext() {
        guard viewContext.hasChanges else {
            return
        }
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
    
    func deleteItem(_ todo: ToDo) {
        viewContext.delete(todo)
    }
}
