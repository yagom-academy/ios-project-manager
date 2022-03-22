//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation
import Firebase

final class FirebaseManager: RemoteRepositoryManager {
   
    private lazy var database = Firestore.firestore()
    private var datas: [FirebaseTask] = []
    private let collectionLink = "tasks"
    
    var fetchAllRecords: [FirebaseTask] {
        return datas
    }
    
    func create(_ object: FirebaseTask) {
        let reference = database.collection(collectionLink).document(object.id)
        reference.setData([
            "id": object.id,
            "title": object.title,
            "description": object.description,
            "dueDate": object.dueDate,
            "status": object.status
        ])
    }
    
    func fetch() {
        let reference = database.collection(collectionLink)
        reference.getDocuments { snapshot, error in
            if error == nil {
                let result = snapshot?.documents.map({ documentSnapshot -> FirebaseTask in
                    let taskData = documentSnapshot.data()
                    return FirebaseTask(
                        id: taskData["id"] as? String ?? "",
                        title: taskData["title"] as? String ?? "",
                        description: taskData["description"] as? String ?? "",
                        dueDate: taskData["dueDate"] as? Double ?? 0,
                        status: taskData["status"] as? Int ?? 1
                    )
                })
                self.datas = result ?? []
            }
        }
    }
    
    func remove(_ object: FirebaseTask) {
        let reference = database.collection(collectionLink).document(object.id)
        reference.delete()
    }
    
    func removeAll() {
        print(#function)
        
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
