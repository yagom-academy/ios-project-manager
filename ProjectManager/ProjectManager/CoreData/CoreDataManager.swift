import Foundation
import CoreData

class CoreDataManager<T: NSManagedObject> {
    private let persistentContainer: NSPersistentCloudKitContainer
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    init(entityName: String) {
        persistentContainer = NSPersistentCloudKitContainer(name: entityName)
        loadPersistentContainer()
    }
    
    private func loadPersistentContainer() {
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func saveContextChange() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func create(values: [String: Any], errorHandler: (Error) -> Void) {
        let object = T(context: context)
        values.forEach { (key, value) in
            object.setValue(value, forKey: key)
        }
        do {
            try saveContextChange()
        } catch {
            errorHandler(error)
        }
    }
    
    func fetch(request: NSFetchRequest<T>, errorHandler: (Error) -> Void) -> [T] {
        do {
            return try context.fetch(request)
        } catch {
            errorHandler(error)
        }
        
        return []
    }
    
    func update(object: T, values: [String: Any], errorHandler: (Error) -> Void) {
        values.forEach { (key, value) in
            object.setValue(value, forKey: key)
        }
        do {
            try saveContextChange()
        } catch {
            errorHandler(error)
        }
    }
    
    func delete(data: T, errorHandler: (Error) -> Void) {
        context.delete(data)
        do {
            try saveContextChange()
        } catch {
            errorHandler(error)
        }
    }
}
