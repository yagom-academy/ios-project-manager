import Foundation
import UIKit
import CoreData

final class CoredataListManger: ListManager {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private lazy var fetchedController = createListFetchedResultsController()
    var list: [Listable] = []
    
    func creatProject(attributes: [String : Any]) -> Listable {
        let projectToCreate = self.createCDProject(attributes: attributes)
        self.fetch()
        
        return projectToCreate
    }
    
    func readProject(index: IndexPath) -> Listable {
        self.fetchedController.object(at: index)
        self.fetch()
    }
    
    func updateProject(to index: IndexPath, how attributes: [String : Any]) -> Listable {
        let projectToUpdate = self.fetchedController.object(at: index)
        attributes.forEach { (key: String, value: Any) in
            projectToUpdate.setValue(value, forKey: key)
        }
        self.fetch()
    }
    
    func deleteProject(index: IndexPath) {
        let projectToDelete = self.fetchedController.object(at: index)
        self.context?.delete(projectToDelete)
        self.fetch()
    }
    
    func fetch() {
        self.saveContext()
        
        guard let fetchedList = self.fetchedController.fetchedObjects
        else {
            return
        }
        
        list = fetchedList
    }
    
    private func createCDProject(attributes: [String: Any]) -> CDProject {
        
        guard let context = self.context
        else {
            return CDProject()
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: String(describing: CDProject.self), in: context)
        else {
            return CDProject()
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
    
    private func createListFetchedResultsController() -> NSFetchedResultsController<CDProject> {
        
        guard let context = self.context else {
            return NSFetchedResultsController()
        }
        
        let fetchRequest = NSFetchRequest<CDProject>(entityName: String(describing: CDProject.self))
        
        let sortDescriptor = NSSortDescriptor(key: "deadline", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedController.performFetch()
        } catch {
            
        }
        return fetchedController
    }
}
