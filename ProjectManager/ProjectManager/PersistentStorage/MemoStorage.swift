//
//  MemoStorage.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/09.
//

import Foundation
import CoreData

final class MemoStorage {
    static let shared = MemoStorage()

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MemoStorage")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("\(error.userInfo)")
            }
        }
        return container
    }()
    
    private init() { }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
