//
//  RemoteDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import FirebaseDatabase

final class RemoteDBManager: DatabaseManagable {
    var ref: DatabaseReference?
    
    init() {
        ref = Database.database().reference()
    }
    
    func create(object: Storable) {
        let dict = object.convertedDictonary
        
        ref?.child("Task").child("\(object.id.uuidString)").setValue(dict)
    }
    
    func fetch(_ completion: @escaping (Result<[Storable], Error>) -> Void) {
        ref?.child("Task").getData(completion: { error, snapshot in
            guard error == nil else {
                completion(.failure(GeneratedTaskError.descriptionEmpty))
                return
            }
            
            let snapshotValue = snapshot?.value as? NSDictionary
            var fetchedData: [Storable] = []
            
            snapshotValue?.forEach({ key, value in
                let value = value as? NSDictionary
                guard let task = Task.convertToStorable(value) else { return }
                fetchedData.append(task)
            })
            
            completion(.success(fetchedData))
        })
    }
    
    func delete(object: Storable) {
        ref?.child("Task").child("\(object.id.uuidString)").removeValue()
    }
    
    func update(object: Storable) {
        let dict = object.convertedDictonary
        
        ref?.child("Task").child("\(object.id.uuidString)").updateChildValues(dict)
    }
}
