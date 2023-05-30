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
    
    func createTask(_ task: Task) {
        let dict = convertToDictonary(task)
        
        ref?.child("Task").child("\(task.id.uuidString)").setValue(dict)
    }
    
    func fetchTasks(_ completion: @escaping (Result<[Task], Error>) -> Void) {
        ref?.child("Task").getData(completion: { error, snapshot in
            guard error == nil else {
                completion(.failure(GeneratedTaskError.descriptionEmpty))
                return
            }
            
            let snapshotValue = snapshot?.value as? NSDictionary
            var tasks: [Task] = []
            
            snapshotValue?.forEach({ key, value in
                guard let task = self.convertToTask(value) else { return }
                tasks.append(task)
            })
            
            completion(.success(tasks))
        })
    }
    
    func deleteTask(_ task: Task) {
        ref?.child("Task").child("\(task.id.uuidString)").removeValue()
    }
    
    func updateTask(_ task: Task) {
        let dict = convertToDictonary(task)
        
        ref?.child("Task").child("\(task.id.uuidString)").updateChildValues(dict)
    }
}
