//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 19/07/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
import RealmSwift

protocol FirebaseManagerAble {
    func create<T: FirebaseDatable>(_ data: T) throws
    func readAll<T: FirebaseDatable> (completion: @escaping ([T]) -> Void)
    func update<T: FirebaseDatable>(updatedData: T) throws
    func delete<T: FirebaseDatable>(_ data: T) throws
}

protocol NetworkConnectionDelegate: AnyObject {
    func offline()
    func online()
}

protocol FirebaseEventObserveDelegate: AnyObject {
    func added(snapshot: DataSnapshot)
    func changed(snapshot: DataSnapshot)
    func removed(snapshot: DataSnapshot)
}

//: DatabaseManagerable
final class FirebaseManager: FirebaseManagerAble {
    
    private var database: DatabaseReference
    weak var networkConnectionDelegate: NetworkConnectionDelegate?
    weak var firebaseEventObserveDelegate: FirebaseEventObserveDelegate?
    
    init(firebaseReference: DatabaseReference = Database.database().reference()) {
        self.database = firebaseReference
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if snapshot.value as? Bool ?? false {
                self.networkConnectionDelegate?.online()
            } else {
                self.networkConnectionDelegate?.offline()
            }
        })
    }
    
    func observe<T: FirebaseDatable>(_: T.Type) {
        let observeRef = T.path.reduce(database) { database, path in
            database.child(path)
        }
        
        observeRef.observe(DataEventType.childAdded) { snapshot in
            self.firebaseEventObserveDelegate?.added(snapshot: snapshot)
        }
        
        observeRef.observe(DataEventType.childChanged) { snapshot in
            self.firebaseEventObserveDelegate?.changed(snapshot: snapshot)
        }
        
        observeRef.observe(DataEventType.childRemoved) { snapshot in
            self.firebaseEventObserveDelegate?.removed(snapshot: snapshot)
        }
    }
    
    func create<T: FirebaseDatable>(_ data: T) throws {
        guard let encodedValues = data.toDictionary else {
            return
        }
        
        let taskItemRef = data.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.setValue(encodedValues)
    }
    
    func readAll<T: FirebaseDatable>(completion: @escaping ([T]) -> Void) {
        
        let taskItemRef = T.path.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.getData { error, dataSnapshot in
            guard error == nil, let dataSnapshot = dataSnapshot
            else {
                return
            }
            
            guard let childArray = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            let array = childArray.compactMap { child in
                try? child.data(as: T.self)
            }
            
            completion(array)
        }
    }
    
    func update<T: FirebaseDatable>(updatedData: T) throws {
        guard let encodedValues = updatedData.toDictionary else {
            return
        }
        
        let taskItemRef = updatedData.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.updateChildValues(encodedValues)
    }
    
    func delete<T: FirebaseDatable>(_ data: T) throws {
        
        let taskItemRef = data.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.removeValue()
    }
}
