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

//: DatabaseManagerable
final class FirebaseManager: FirebaseManagerAble {
    
    private var database: DatabaseReference
    
    init(firebaseReference: DatabaseReference = Database.database().reference()) {
        self.database = firebaseReference
    }
    
    func create<T: FirebaseDatable>(_ data: T) throws {
        guard let encodedValues = (data as? Encodable)?.toDictionary else {
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
        guard let encodedValues = (updatedData as? Encodable)?.toDictionary else {
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
