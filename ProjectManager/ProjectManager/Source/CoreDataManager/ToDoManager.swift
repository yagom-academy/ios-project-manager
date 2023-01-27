//  ProjectManager - ToDoManager.swift
//  created by zhilly on 2023/01/27

import Foundation
import CoreData

final class ToDoManager: CoreDataManageable {

    static let shared = ToDoManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoCoreData")
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    func add(_ todo: ToDo) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "ToDoCoreModel", in: context) else {
            throw ToDoError.failedFetchEntity
        }
        let todoObject = NSManagedObject(entity: entity, insertInto: context)
        
        todoObject.setValue(todo.title, forKey: "title")
        todoObject.setValue(todo.body, forKey: "body")
        todoObject.setValue(todo.deadline, forKey: "deadline")
        todoObject.setValue(todo.state.rawValue, forKey: "state")
        
        try context.save()
    }
    
    func fetchObjects() throws -> [ToDo] {
        let fetchRequest: NSFetchRequest<ToDoCoreModel> = ToDoCoreModel.fetchRequest()
        let result = try context.fetch(fetchRequest)
        
        return result.compactMap({ ToDo(from: $0) })
    }
    
    func update(_ todo: ToDo) throws {
        guard let objectID = fetchObjectID(from: todo.objectID) else {
            throw ToDoError.invalidObjectID
        }
        let todoObject = context.object(with: objectID)
        
        todoObject.setValue(todo.title, forKey: "title")
        todoObject.setValue(todo.body, forKey: "body")
        todoObject.setValue(todo.deadline, forKey: "deadline")
        todoObject.setValue(todo.state.rawValue, forKey: "state")
        
        try context.save()
    }
    
    func remove(_ todo: ToDo) throws {
        guard let objectID = fetchObjectID(from: todo.objectID) else {
            throw ToDoError.invalidObjectID
        }
        let todoObject = context.object(with: objectID)
        
        context.delete(todoObject)
        try context.save()
    }
    
    private func fetchObjectID(from diaryID: String?) -> NSManagedObjectID? {
        guard let diaryID = diaryID,
              let objectURL = URL(string: diaryID),
              let storeCoordinator = context.persistentStoreCoordinator,
              let objectID = storeCoordinator.managedObjectID(forURIRepresentation: objectURL) else {
            return nil
        }
        return objectID
    }
}
