import UIKit
import CoreData

final class CoredataRepository: DataRepository {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var list = [Listable]()
    
    func creat(attributes: [String : Any]) {
        let projectToCreate = self.createCDProject(attributes: attributes)
        self.fetch()
    }
    
    func read(identifier: String) -> Listable? {
        (list.filter { $0.identifier == identifier }).first
    }
    
    func update(identifier: String, how attributes: [String : Any]) {
        let projectToUpdate = (list.filter { $0.identifier == identifier }).first
        
        guard let project = projectToUpdate as? NSManagedObject
        else {
            return
        }
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
        self.context?.delete(project)
        self.fetch()
    }
    
    func fetch() {
        
        guard let context = self.context
        else {
            return
            }
        
        guard let data = try? context.fetch(CDProject.fetchRequest())
        else {
            return
        }
        
        self.list = data
        self.saveContext()
    }
    
    private func createCDProject(attributes: [String: Any]) {
        
        guard let context = self.context
        else {
            return
        }
        
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
        
        guard let context = self.context
        else {
            return
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
