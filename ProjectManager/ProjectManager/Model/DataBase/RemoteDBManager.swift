//
//  RemoteDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import FirebaseDatabase

final class RemoteDBManager: DatabaseManagable {
    
    var ref: DatabaseReference?
    var errorHandler: ((Error) -> Void)?
    
    init(errorHandler: ((Error) -> Void)?) {
        self.errorHandler = errorHandler
        ref = Database.database().reference()
    }
    
    func synchronizeObjects(_ objects: [Storable]) {
        objects.forEach { object in
            create(object: object)
        }
    }
    
    func create(object: Storable) {
        guard let ref = self.ref else {
            errorHandler?(DatabaseError.createError)
            return
        }
        
        let dict = object.convertedDictonary
        
        ref.child("Task").child("\(object.id.uuidString)").setValue(dict)
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        ref?.child("Task").getData(completion: { error, snapshot in
            guard error == nil else {
                completion(.failure(DatabaseError.fetchedError))
                return
            }
            
            let snapshotValue = snapshot?.value as? NSDictionary
            var fetchedData: [Storable] = []
            
            snapshotValue?.forEach({ key, value in
                let value = value as? NSDictionary
                
                guard let task = Task.convertToStorable(value) else {
                    return
                }
                
                fetchedData.append(task)
            })
            
            completion(.success(fetchedData))
        })
    }
    
    func delete(object: Storable) {
        guard let ref = self.ref else {
            errorHandler?(DatabaseError.createError)
            return
        }
        
        ref.child("Task").child("\(object.id.uuidString)").removeValue()
    }
    
    func update(object: Storable) {
        guard let ref = self.ref else {
            errorHandler?(DatabaseError.createError)
            return
        }
        
        let dict = object.convertedDictonary
        
        ref.child("Task").child("\(object.id.uuidString)").updateChildValues(dict)
    }
}
