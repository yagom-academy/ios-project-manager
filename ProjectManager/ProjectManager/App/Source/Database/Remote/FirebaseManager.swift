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
    private let database = Firestore.firestore()
    private var snapShotListener: ListenerRegistration?
    
    func addListener<DTO: DataTransferObject> (_ type: DTO.Type,
                                        createCompletion: ((DTO) -> Void)? = nil,
                                        updateCompletion: ((DTO) -> Void)? = nil,
                                        deleteCompletion: ((DTO) -> Void)? = nil) {
        let collectionName = String(describing: type)
        let databaseReference = database.collection(collectionName)
        
        snapShotListener = databaseReference.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach { diff in
                guard let dto = try? diff.document.data(as: type) else { return }
                
                if diff.type == .added {
                    createCompletion?(dto)
                    return
                }
                
                if diff.type == .modified {
                    updateCompletion?(dto)
                    return
                }
                
                if diff.type == .removed {
                    deleteCompletion?(dto)
                    return
                }
            }
        }
    }
    
    func removeListener() {
        snapShotListener?.remove()
    }
    
    func fetch<DTO: DataTransferObject> (_ type: DTO.Type, completion: @escaping ([DTO]) -> ()) {
        let collectionName = String(describing: type)
        let databaseReference = database.collection(collectionName)
        
        databaseReference.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            
            var taskList: [DTO] = []
            let jsonDecoder = JSONDecoder()
            
            documents.forEach { document in
                do {
                    let data = document.data()
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let task = try jsonDecoder.decode(type, from: jsonData)
                    
                    taskList.append(task)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            completion(taskList)
        }
    }
    
    func save<DTO: DataTransferObject>(_ data: DTO) {
        let collectionName = String(describing: type(of: data))
        let databaseReference = database.collection(collectionName)
        
        do {
            try databaseReference.document(data.id.uuidString).setData(from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func save<DTO: DataTransferObject>(_ data: [DTO]) {
        data.forEach {
            let collectionName = String(describing: type(of: $0))
            let databaseReference = database.collection(collectionName)
            
            do {
                try databaseReference.document($0.id.uuidString).setData(from: $0)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete<DTO: DataTransferObject>(type: DTO.Type, id: UUID) {
        let collectionName = String(describing: type)
        let databaseReference = database.collection(collectionName)
        
        databaseReference.document(id.uuidString).delete()
    }
}
