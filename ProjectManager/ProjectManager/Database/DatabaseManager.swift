//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/29.
//

import RxSwift
import Foundation

final class DatabaseManager: DatabaseManageable {
    private let firebaseManager = FirebaseManager.shared
    private let coredataManager = CoreDataManager.shared
    
    func saveWork(_ work: Work) {
        firebaseManager.saveWork(work)
        coredataManager.saveWork(work)
    }
    
    func deleteWork(id: UUID) {
        firebaseManager.deleteWork(id: id)
        coredataManager.deleteWork(id: id)
    }
    
    func fetchWork() -> Observable<[Work]> {
        return coredataManager.fetchWork()
    }
}
