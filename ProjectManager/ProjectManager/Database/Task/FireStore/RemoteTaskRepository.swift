//
//  FireStoreTaskRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import FirebaseCore
import FirebaseFirestore

final class RemoteTaskRepository: TaskRepository {

    private let firebase: Firestore
    
    init() {
        FirebaseApp.configure()
        self.firebase = Firestore.firestore()
    }
    
    
    func fetchAll() -> [Task] {
        print("파이어베이스에서 데이터를 가져왔습니다.")
        return []
    }
    
    func save(_ task: Task) {
        print("파이어베이스에서 데이터를 저장했습니다.")
    }
    
    func update(id: UUID, new task: Task) {
        print("파이어베이스에서 데이터를 저장했습니다.")
    }
    
    func delete(task: Task) {
        print("파이어베이스에서 데이터를 삭제했습니다.")
    }
    
    func fetch(id: UUID) -> Task? {
        print("파이어베이스에서 \(id)에 해당하는 데이터를 가져왔습니다.")
        return nil
    }
}
