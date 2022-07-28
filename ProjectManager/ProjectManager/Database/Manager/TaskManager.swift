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

// 호출 순서 주의: realm에서 먼저 생성 시 오류 발생
final class TaskManager {
    private let firebaseManager: FirebaseManager
    private let realmManager: RealmManagerable
    
    init(realmManager: RealmManagerable? = RealmManager.shared,
         firebaseManager: FirebaseManager = FirebaseManager()) throws {
        guard let realmManager = realmManager else { throw RealmError.initializationError }
        self.firebaseManager = firebaseManager
        self.realmManager = realmManager
    }
    
    func create(task: Task) throws {
        try firebaseManager.create(task)
        try realmManager.create(task)
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
    
    func update(task: Task) throws {
        try firebaseManager.update(updatedData: task)
        try realmManager.update(updatedData: task)
    }
    
    func delete(task: Task) throws {
        try firebaseManager.delete(task)
        try realmManager.delete(task)
    }
    
    func deleteAll() throws {
        try realmManager.deleteAll()
    }
    
    func sync(complete: @escaping () -> Void) throws {
        let firebaseDataCompletion: ([Task]) -> Void = { tasks in
            try? self.realmManager.deleteAll()
            tasks.forEach { task in
                try? self.realmManager.update(updatedData: task)
            }
            complete()
        }
        
        firebaseManager.readAll(completion: firebaseDataCompletion)
    }
    
    func setNetworkConnectionDelegate(delegate: NetworkConnectionDelegate) {
        firebaseManager.networkConnectionDelegate = delegate
    }
    
    func setFirebaseEventObserveDelegate(delegate: FirebaseEventObserveDelegate) {
        firebaseManager.firebaseEventObserveDelegate = delegate
        self.firebaseManager.observe(Task.self)
    }
}
