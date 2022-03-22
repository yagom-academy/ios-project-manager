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
    
    func create(_ object: FirebaseTask) {
        let reference = database.collection(collectionLink).document(object.id.uuidString)
        reference.setData([
            "id": object.id.uuidString,
            "title": object.title,
            "description": object.description,
            "dueDate": object.dueDate,
            "status": object.status
        ])
    }
    
    func removeAll() {
        let reference = database.collection(collectionLink)
        reference.getDocuments { snapshot, error in
            if error == nil {
                snapshot?.documents.forEach({ taskDocument in
                    taskDocument.reference.delete()
                })
            }
        }
    }
    
}
