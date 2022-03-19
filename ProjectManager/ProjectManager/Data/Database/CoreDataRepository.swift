import Foundation
import CoreData
import RxSwift

final class CoredataRepository: DataRepository { 
    
    private let context: NSManagedObjectContext
    private var list = [Listable]()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(object: Listable) {
        let attributes = self.convertListToAttributes(from: object)
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
    
    func extractRxAll() -> Observable<[Listable]> {
        return Observable.create { emitter in
            let lists = self.extractAll()
            emitter.onNext(lists)
            return Disposables.create()
        }
    }
    

    
    private func convertListToAttributes(from list: Listable) -> [String: Any] {
        var attributes = [String: Any]()
        attributes.updateValue(list.name, forKey: "name")
        attributes.updateValue(list.detail, forKey: "detail")
        attributes.updateValue(list.identifier, forKey: "identifier")
        attributes.updateValue(list.progressState, forKey: "progressState")
        attributes.updateValue(list.deadline, forKey: "deadline")
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
        
            }
        }
    }
}
