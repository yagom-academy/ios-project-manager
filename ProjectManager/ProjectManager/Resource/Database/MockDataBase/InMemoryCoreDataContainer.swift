//
//  InMemoryCoreDataContainer.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/14.
//

import CoreData

final class InMemoryCoreDataContainer: NSPersistentContainer {
    init(name: String, bundle: Bundle = .main, inMemory: Bool = true) {
        guard let model = NSManagedObjectModel.mergedModel(from: [bundle]) else {
            fatalError("Failed to create model")
        }

        super.init(name: name, managedObjectModel: model)
        configureDefaults(inMemory)
    }

    private func configureDefaults(_ inMemory: Bool = false) {
        if let storeDescription = persistentStoreDescriptions.first {
            storeDescription.shouldAddStoreAsynchronously = true
            if inMemory {
                storeDescription.url = URL(fileURLWithPath: "/dev/null")
                storeDescription.shouldAddStoreAsynchronously = false
            }
        }
    }
}
