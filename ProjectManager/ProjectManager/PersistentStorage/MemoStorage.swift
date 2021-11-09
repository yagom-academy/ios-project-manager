//
//  MemoStorage.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/09.
//

import Foundation
import CoreData

final class MemoStorage {
    private let entityName = "MemoEntity"
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MemoStorage")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("\(error.userInfo)")
            }
        }
        return container
    }()
}
