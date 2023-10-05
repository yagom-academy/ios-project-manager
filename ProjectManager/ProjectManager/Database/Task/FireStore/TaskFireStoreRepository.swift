//
//  FireStoreTaskRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import FirebaseCore
import FirebaseFirestore

final class TaskFireStoreRepository: TaskRemoteRepository {
    
    private let firebase: Firestore
    
    init() {
        FirebaseApp.configure()
        self.firebase = Firestore.firestore()
    }
    
    func fetchAll(by: User) -> [Task] {
        []
    }
    
    func syncronize(from localTasks:[Task], by: User) {
        
    }
    
    func save(_ task: Task, by: User) {
        
    }
    
    func update(id: UUID, new task: Task, by: User) {
        
    }
    
    func delete(_ task: Task, by: User) {
        
    }
}
