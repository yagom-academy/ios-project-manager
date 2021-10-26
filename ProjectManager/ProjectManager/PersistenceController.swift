//
//  PersistenceController.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container = NSPersistentContainer(name: "ProjectManager")

    init() {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
