//
//  CoreDataStorage.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/09.
//

import Foundation
import CoreData

final class CoreDataStorage {
    static let shared = CoreDataStorage()
    private let coreDataSerialQueue = DispatchQueue(label: "CoreDataStorage")

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
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
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        coreDataSerialQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            self.persistentContainer.performBackgroundTask(block)
        }
    }
}
