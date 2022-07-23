//
//  CoreDataStorage.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import CoreData

final class CoreDataStorage: CoreDataStoragable {
  private enum Settings {
    static let defaultLocalDatabaseName = "LocalDB"
  }
  
  static let standard = CoreDataStorage()
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: databaseName)
    container.loadPersistentStores { description, error in
      if let error = error {
        assertionFailure(CoreDataStorageError.loadPersistentStoreFailure.description)
      }
    }
    return container
  }()
  private var context: NSManagedObjectContext { persistentContainer.viewContext }
  private let databaseName: String
  
  init(databaseName: String = Settings.defaultLocalDatabaseName) {
    self.databaseName = databaseName
  }
  
  func createObject(for entityName: String) -> NSManagedObject? {
    guard let entityDescription = NSEntityDescription.entity(
      forEntityName: entityName,
      in: context) else { return nil }
    
    return NSManagedObject(entity: entityDescription, insertInto: context)
  }
  
  func fetchObject(for entityName: String, id: String) -> NSManagedObject? {
    let request = createFilteredRequest(for: entityName, id: id)
    guard let object = try? context.fetch(request).first else { return nil }
    
    return object as? NSManagedObject
  }
  
  func fetchObjects(for entityName: String) -> [NSManagedObject]? {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    guard let object = try? context.fetch(request) else { return nil }
    
    return object as? [NSManagedObject]
  }
  
  func deleteObjectWithSave(for entityName: String, id: String) -> Bool {
    guard let object = fetchObject(for: entityName, id: id) else { return false }
    context.delete(object)
    return saveContext()
  }
  
  func deleteObjects(for entityName: String) -> Bool {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    
    do {
      try context.execute(deleteRequest)
      return true
    } catch {
      return false
    }
  }
  
  func saveContext() -> Bool {
    guard context.hasChanges else { return false }
    
    do {
      try context.save()
      return true
    } catch {
      assertionFailure(CoreDataStorageError.saveContextFailure(error).description)
      return false
    }
  }
}

// MARK: - Private

extension CoreDataStorage {
  private func createFilteredRequest(
    for entityName: String,
    id: String
  ) -> NSFetchRequest<NSFetchRequestResult> {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    request.predicate = NSPredicate(format: "id = %@", id)
    return request
  }
}
