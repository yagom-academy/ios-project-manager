//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/30.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    enum CollectionName {
        case entity
        
        var description: String {
            return String(describing: self).capitalized
        }
    }
    
    enum DocumentName {
        case myTask
        case history
        
        var description: String {
            return String(describing: self).capitalized
        }
    }
    
    private let db = Firestore.firestore()
    private let collectionName: String
    private let documentName: String
    
    init(collectionName: CollectionName, documentName: DocumentName) {
        self.collectionName = collectionName.description
        self.documentName = documentName.description
    }
    
    func upload(_ data: [MyTask]) {
        let dbRef = db.collection(collectionName).document(documentName)

        data.forEach { myTask in
            let dic = [
                "id": myTask.id.uuidString,
                "state": myTask.state.description,
                "title": myTask.title,
                "body": myTask.body,
                "deadline": myTask.deadline.description
            ] as [String: Any]
            
            dbRef.updateData(["taskList": FieldValue.arrayUnion([dic])])
        }
    }
}
