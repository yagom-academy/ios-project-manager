//
//  RemoteDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import FirebaseDatabase

final class RemoteDBManager: DatabaseManagable {
    
    private var databaseReference: DatabaseReference?
    var errorHandler: ((Error) -> Void)?
    
    init(errorHandler: ((Error) -> Void)?) {
        self.errorHandler = errorHandler
        databaseReference = Database.database().reference()
    }
    
    deinit {
        databaseReference?.cancelDisconnectOperations()
    }
    
    func create(object: Storable) {
        guard let databaseReference = self.databaseReference else {
            errorHandler?(DatabaseError.createError)
            return
        }
        
        let dict = object.convertedDictonary
        
        databaseReference.child("Task").child("\(object.id.uuidString)").setValue(dict)
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        databaseReference?.child("Task").getData(completion: { error, snapshot in
            if error == nil {
                let snapshotValue = snapshot?.value as? NSDictionary
                var fetchedData: [Storable] = []
                
                snapshotValue?.forEach({ key, value in
                    let value = value as? NSDictionary
                    
                    if let task = Task.convertToStorable(value) {
                        fetchedData.append(task)
                    }
                })
                
                completion(.success(fetchedData))
                return
            }
            
            completion(.failure(DatabaseError.fetchedError))
        })
    }
    
    func delete(object: Storable) {
        guard let databaseReference = self.databaseReference else {
            errorHandler?(DatabaseError.createError)
            return
        }
        
        databaseReference.child("Task").child("\(object.id.uuidString)").removeValue()
    }
    
    func update(object: Storable) {
        guard let databaseReference = self.databaseReference else {
            errorHandler?(DatabaseError.createError)
            return
        }
        
        let dict = object.convertedDictonary
        
        databaseReference.child("Task").child("\(object.id.uuidString)").updateChildValues(dict)
    }
}
