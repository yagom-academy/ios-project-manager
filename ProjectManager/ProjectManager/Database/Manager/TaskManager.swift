//
//  TaskManager.swift
//  TaskManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation

enum RealmError: Error {
    case initializationError
}

final class TaskManager {
    private let realmManager: RealmManagerable
    private let firebaseManager: FirebaseManager
    
    init(realmManager: RealmManagerable? = RealmManager.shared,
         firebaseManager: FirebaseManager = FirebaseManager()) throws {
        guard let realmManager = realmManager else { throw RealmError.initializationError }
        self.realmManager = realmManager
        self.firebaseManager = firebaseManager
    }
    
    func create(task: Task) throws {
        try realmManager.create(task)
        try firebaseManager.create(task)
    }
    
    func read(id: String) -> Task? {
        let predicate = NSPredicate(format: "id = %@", id)
        return realmManager.read(predicate).first
    }
    
    func read(type: TaskType) -> [Task] {
        let predicate = NSPredicate(format: "type = %@", type.rawValue)
        return realmManager.read(predicate)
    }
    
    func readAll() -> [Task] {
        return realmManager.readAll()
    }
    
    func update(task: Task, updateHandler: (Task) -> Void) throws {
        try realmManager.update(data: task, updateHandler: updateHandler)
        try firebaseManager.update(updatedData: task)
    }
    
    func delete(task: Task) throws {
        try realmManager.delete(task)
        try firebaseManager.delete(task)
    }
    
    func deleteAll() throws {
        try realmManager.deleteAll()
    }
}
