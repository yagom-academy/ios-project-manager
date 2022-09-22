//
//  FirebaseService.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/22.
//

import FirebaseFirestore
import RxSwift

class FirebaseService {
    func loadData(_ collectionId: String) -> Observable<[QueryDocumentSnapshot]> {
        return Observable.create { emitter in
            let database = Firestore.firestore()
            
            database.collection(collectionId).getDocuments { querySnapshot, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    emitter.onNext(documents)
                    emitter.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    func convert(form document: QueryDocumentSnapshot) -> Work? {
        guard let uuid = document["id"] as? String,
              let title = document["title"] as? String,
              let stateValue = document["state"] as? String,
              let content = document["content"] as? String,
              let deadline = document["deadline"] as? Timestamp,
              let id = UUID(uuidString: uuid),
              let state = WorkState(rawValue: stateValue) else { return nil }
        
        return Work(id: id, title: title, content: content, deadline: deadline.dateValue(), state: state)
    }
}
