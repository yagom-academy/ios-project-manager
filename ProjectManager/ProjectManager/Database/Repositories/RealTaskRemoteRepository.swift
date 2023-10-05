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
                        print("Error removing document: \(err)")
                        continuation.resume(returning: [])
                    } else {
                        if let documents = snapshot?.documents {
                            let tasks = documents.compactMap {
                                let data = $0.data()
                                let id = data["id"] as? String ?? ""
                                let title = data["title"] as? String ?? ""
                                let content = data["content"] as? String ?? ""
                                let date = (data["date"] as? Timestamp)?.dateValue() ?? .now
                                let state = data["state"] as? Int8 ?? 1

                                return TaskDTO(id: id, title: title, content: content, date: date, state: state).toDomain()
                            }
                                
                            continuation.resume(returning: tasks)
                        }
                    }
                }
        }
    }
    
    func syncronize(from localTasks:[Task], by user: User) {
        for task in localTasks {
            save(task, by: user)
        }
    }
    
    func save(_ task: Task, by user: User) {
        do {
            try firebase
                .collection(user.email)
                .document(task.id.uuidString)
                .setData(from: task.toDTO())
        } catch {
            print("firestore save fail")
        }
    }
    
    func update(id: UUID, new task: Task, by user: User) {
        do {
            try firebase
                .collection(user.email)
                .document(id.uuidString)
                .setData(from: task.toDTO())
        } catch {
            print("firestore update fail")
        }
    }
    
    func delete(_ task: Task, by user: User) {
        firebase
            .collection(user.email)
            .document(task.id.uuidString)
            .delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
    }
    
    private func deleteAll(by user: User) {
        firebase
            .collection(user.email)
            .getDocuments { snapshot, err in                
                if let documents = snapshot?.documents {
                    documents.forEach {
                        $0.reference.delete()
                    }
                }
            }
    }
}
