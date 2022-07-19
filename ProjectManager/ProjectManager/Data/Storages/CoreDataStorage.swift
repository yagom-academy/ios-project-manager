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
  
  private enum Message {
    static let loadPersistentStoreFailureMessage = "영구 저장소를 불러오는데 실패했습니다."
    static let saveContextFailureMessage = "영구 저장소에 저장하는데 실패했습니다."
  }
  
  static let shared = CoreDataStorage()
  
  private lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: Settings.localDataBaseName)
    container.loadPersistentStores { description, error in
      if let error = error { assertionFailure(Message.loadPersistentStoreFailureMessage) }
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
        assertionFailure(Message.saveContextFailureMessage)
      }
    }
  }
}
