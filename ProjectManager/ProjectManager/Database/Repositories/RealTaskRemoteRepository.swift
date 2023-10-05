//
//  FireStoreTaskRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import FirebaseCore
import FirebaseFirestore

final class RealTaskRemoteRepository: TaskRemoteRepository {
    
    private let firebase: Firestore
    
    init() {
        FirebaseApp.configure()
        self.firebase = Firestore.firestore()
    }
    
    func fetchAll(by user: User) async -> [Task] {
        return await withCheckedContinuation { continuation in
            firebase
                .collection(user.email)
                .getDocuments { snapshot, err in
                    if let err = err {
                        print("[\(user.email)] 데이터를 불러오는데 실패했습니다 \(err.localizedDescription)")
                        continuation.resume(returning: [])
                    } else {
                        if let documents = snapshot?.documents {
                            let tasks = documents.compactMap {
                                let data = $0.data()
                                let id = data["id"] as? String ?? ""
                                let title = data["title"] as? String ?? ""
                                let content = data["content"] as? String ?? ""
                                let date = (data["date"] as? Timestamp)?.dateValue() ?? .now
                                let state = data["state"] as! Int

                                return TaskDTO(id: id, title: title, content: content, date: date, state: state).toDomain()
                            }
                            
                            print("[\(user.email)] 데이터를 불러오는데 성공했습니다.")
                            continuation.resume(returning: tasks)
                        }
                    }
                }
        }
    }
    
    func save(_ task: Task, by user: User) {
        do {
            try firebase
                .collection(user.email)
                .document(task.id.uuidString)
                .setData(from: task.toDTO())
            
            print("[\(user.email)] '\(task.title)'이 서버에 성공적으로 저장되었습니다.")
        } catch {
            print("[\(user.email)] '\(task.title)' 저장에 실패하였습니다. \(error.localizedDescription)")
        }
    }
    
    func update(id: UUID, new task: Task, by user: User) {
        do {
            try firebase
                .collection(user.email)
                .document(id.uuidString)
                .setData(from: task.toDTO())
            
            print("[\(user.email)] '\(task.title)'을 서버에 성공적으로 수정하였습니다.")
        } catch {
            print("[\(user.email)] '\(task.title)' 수정에 실패하였습니다. \(error.localizedDescription)")
        }
    }
    
    func delete(_ task: Task, by user: User) {
        firebase
            .collection(user.email)
            .document(task.id.uuidString)
            .delete() { err in
                if let err = err {
                    print("[\(user.email)] '\(task.title)'을 삭제하는데 실패했습니다. \(err.localizedDescription)")
                } else {
                    print("[\(user.email)] '\(task.title)'을 서버에 성공적으로 삭제하였습니다.")
                }
            }
    }
}
