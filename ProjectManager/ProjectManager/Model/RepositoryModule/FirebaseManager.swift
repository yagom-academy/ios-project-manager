//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation
import Firebase

final class FirebaseManager: RemoteRepositoryManager {
   
    private let database = Firestore.firestore()
    
    private let collectionLink = "tasks"
    
    func create(_ object: FirebaseTask) async throws {
        let reference = database.collection(collectionLink).document(object.id.uuidString)
        try await reference.setData([
            "id": object.id.uuidString,
            "title": object.title,
            "description": object.description,
            "dueDate": object.dueDate,
            "status": object.status
        ])
    }
    
    func fetch() async throws -> [FirebaseTask] {
        let reference = database.collection(collectionLink)
        let taskDocuments = try await reference.getDocuments()
        let result = taskDocuments.documents.map { snapshot -> FirebaseTask in
            let data = snapshot.data()
            return FirebaseTask(
                id: UUID(uuidString: (data["id"] as? String) ?? "") ?? UUID(),
                title: (data["title"] as? String) ?? "",
                description: (data["description"] as? String) ?? "",
                dueDate: (data["dueDate"] as? Date) ?? Date(),
                status: (data["status"] as? Int) ?? Int()
            )
        }
        return result
    }
    
    func update(_ object: FirebaseTask) async throws {
        try await remove(object)
        try await create(object)
    }
    
    func remove(_ object: FirebaseTask) async throws {
        let reference = database.collection(collectionLink).document(object.id.uuidString)
        try await reference.delete()
    }
    
    func removeAll() async throws {
        let reference = database.collection(collectionLink)
        let documents = try await reference.getDocuments()
        documents.documents.forEach { snapshot in
            snapshot.reference.delete()
        }
    }
    
}
