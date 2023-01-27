//  ProjectManager - HistoryManager.swift
//  created by zhilly on 2023/01/27

import Foundation
import CoreData

final class HistoryManager: CoreDataManageable {

    static let shared = HistoryManager()
    
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
    
    func add(_ history: History) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "HistoryCoreModel", in: context) else {
            throw CoreDataManagerError.failedFetchEntity
        }
        let historyObject = NSManagedObject(entity: entity, insertInto: context)
        
        historyObject.setValue(history.title, forKey: "title")
        historyObject.setValue(history.createdAt, forKey: "createdAt")
        
        try context.save()
    }
    
    func fetchObjects() throws -> [History] {
        let fetchRequest: NSFetchRequest<HistoryCoreModel> = HistoryCoreModel.fetchRequest()
        let result = try context.fetch(fetchRequest)
        
        return result.compactMap({ History(from: $0) })
    }
    
    func update(_ history: History) throws {
        guard let objectID = fetchObjectID(from: history.objectID) else {
            throw CoreDataManagerError.invalidObjectID
        }
        let historyObject = context.object(with: objectID)
        
        historyObject.setValue(history.title, forKey: "title")
        historyObject.setValue(history.createdAt, forKey: "createdAt")
        
        try context.save()
    }
    
    func remove(_  history: History) throws {
        guard let objectID = fetchObjectID(from: history.objectID) else {
            throw CoreDataManagerError.invalidObjectID
        }
        let historyObject = context.object(with: objectID)
        
        context.delete(historyObject)
        try context.save()
    }
    
    private func fetchObjectID(from historyID: String?) -> NSManagedObjectID? {
        guard let historyID = historyID,
              let objectURL = URL(string: historyID),
              let storeCoordinator = context.persistentStoreCoordinator,
              let objectID = storeCoordinator.managedObjectID(forURIRepresentation: objectURL) else {
            return nil
        }
        return objectID
    }
}
