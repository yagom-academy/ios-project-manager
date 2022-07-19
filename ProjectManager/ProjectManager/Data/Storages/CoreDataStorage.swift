//
//  CoreDataStorage.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import CoreData

import RxCocoa

final class CoreDataStorage {
  private enum Settings {
    static let localDataBaseName = "LocalDB"
  }
  
  static let shared = CoreDataStorage()
  
  private lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: Settings.localDataBaseName)
    container.loadPersistentStores { description, error in
      if let error = error { assertionFailure("CoreDataStorage unresolved Error") }
    }
    return container
  }()
  
  var context: NSManagedObjectContext { container.viewContext }
  
  private init() {}
  
  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        assertionFailure("CoreDataStorage unresolved \(error)")
      }
    }
  }
}
