//
//  CoreDataManager.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/28.
//

import CoreData

class CoreDataManager<T> {
    typealias Entity = T
    
    private let modelName: String
    private let entityName: String
    
    init(modelName: String,
         entityName: String) {
        self.modelName = modelName
        self.entityName = entityName
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    func createObject(entityKeyValue: [String: Any]) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                      in: context)
        else { return }
        
        let managerObject = NSManagedObject(entity: entity,
                                            insertInto: context)
        entityKeyValue.forEach {
            managerObject.setValue($0.value,
                                   forKey: $0.key)
        }
        saveContext()
    }
    
    func readObject<Entity>(request: NSFetchRequest<Entity>) -> Result<[Entity], CoreDataError> {
        guard let fetchObject = try? context.fetch(request) as [Entity]
        else { return .failure(.fetch) }
        
        return .success(fetchObject)
    }
    
    func updateObject(object: NSManagedObject,
                      entityKeyValue: [String: Any]) {
        entityKeyValue.forEach { object.setValue($0.value,
                                                 forKey: $0.key) }
        saveContext()
    }
    
    func deleteObject(object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
