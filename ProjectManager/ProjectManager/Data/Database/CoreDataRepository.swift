import UIKit
import CoreData

final class CoredataRepository: DataRepository {
    
    private let context: NSManagedObjectContext
    private var list = [Listable]()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(object: Listable) {
        let attributes = convertListToAttributes(from: object)
        let projectToCreate = self.createCDProject(attributes: attributes)
        self.fetch()
    }
    
    func read(identifier: String) -> Listable? {
        (list.filter { $0.identifier == identifier }).first
    }
    
    func update(identifier: String, how object: Listable) {
        let projectToUpdate = (list.filter { $0.identifier == identifier }).first
        
        guard let project = projectToUpdate as? NSManagedObject
        else {
            return
        }
        
        let attributes = convertListToAttributes(from: object)

        attributes.forEach { (key: String, value: Any) in
            project.setValue(value, forKey: key)
        }
        self.fetch()
    }
    
    func delete(identifier: String) {
        let projectToDelete = (list.filter { $0.identifier == identifier }).first
        
        guard let project = projectToDelete as? NSManagedObject
        else {
            return
        }
        self.context.delete(project)
        self.fetch()
    }
    
    func fetch() {
        
        guard let data = try? context.fetch(CDProject.fetchRequest())
        else {
            return
        }
        
        self.list = data
        self.saveContext()
    }
    
    func extractAll() -> [Listable] {
        self.fetch()
        return list
    }
    
    private func convertListToAttributes(from list: Listable) -> [String: Any] {
        guard let attributes = try? list.toJson()
        else {
            return [:]
        }
        return attributes
    }
    
    private func createCDProject(attributes: [String: Any]) {
        
        guard let entity = NSEntityDescription.entity(
            forEntityName: String(describing: CDProject.self),
            in: context
        )
        else {
            return
        }
        
        let project = NSManagedObject(entity: entity, insertInto: context)
        attributes.forEach { (key: String, value: Any) in
            project.setValue(value, forKey: key)
        }
        self.saveContext()
    }
    
    private func saveContext() {

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                #if DEBUG
                print("error")
                #endif
            }
        }
    }
}
