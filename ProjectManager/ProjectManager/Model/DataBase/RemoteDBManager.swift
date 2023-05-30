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
    
    private func convertToDictonary(_ task: Task) -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict["title"] = NSString(string: task.title)
        dict["description"] = NSString(string: task.description)
        dict["id"] = NSString(string: task.id.uuidString)
        dict["state"] = NSString(string: task.state?.titleText ?? "")
        dict["date"] = NSNumber(value: task.date.timeIntervalSince1970)
        
        return dict
    }
    
    private func convertToTask(_ dictValue: Any) -> Task? {
        let dict = dictValue as? NSDictionary
        
        guard let idValue = dict?.value(forKey: "id") as? String,
              let id = UUID(uuidString: idValue),
              let title = dict?.value(forKey: "title") as? String,
              let description = dict?.value(forKey: "description") as? String,
              let stateValue = dict?.value(forKey: "state") as? String,
              let dateValue = dict?.value(forKey: "date") as? Double else { return nil}
        
        let state = TaskState.checkTodoState(by: stateValue)
        let date = Date(timeIntervalSince1970: dateValue)
        
        return Task(id: id, title: title, description: description, date: date, state: state)
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
