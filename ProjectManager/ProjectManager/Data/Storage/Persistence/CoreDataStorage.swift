//
//  CoreDataStorage.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import CoreData

final class CoreDataStorage {
  private enum Settings {
    static let localDataBaseName = "LocalDB"
  }
  
  static let shared = CoreDataStorage()
  
  private lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: Settings.localDataBaseName)
    container.loadPersistentStores { description, error in
      if let error = error { assertionFailure(CoreDataStorageError.loadPersistentStoreFailure.description) }
    }
    return container
  }()
  
  var context: NSManagedObjectContext { container.viewContext }
  
  private init() {}
  
  func saveContext() {
    if context.hasChanges {
      do {
        try context.save();
      } catch {
        assertionFailure(CoreDataStorageError.saveContextFailure(error).description)
      }
    }
  }
}
