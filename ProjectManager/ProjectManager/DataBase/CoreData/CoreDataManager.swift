//
//  CoreDataManager.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProjectCoreData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("unresolved Error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
