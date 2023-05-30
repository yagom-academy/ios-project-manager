//
//  RemoteDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import FirebaseDatabase

final class RemoteDBManager {
    var ref: DatabaseReference?
    
    init() {
        ref = Database.database().reference()
    }
    
    private func convertToNSDictonary(_ task: Task) -> NSDictionary {
        var dict: [String: Any] = [:]
        
        dict["title"] = NSString(string: task.title)
        dict["description"] = NSString(string: task.description)
        dict["id"] = NSString(string: task.id.uuidString)
        dict["state"] = NSString(string: task.state?.titleText ?? "")
        dict["date"] = NSNumber(value: task.date.timeIntervalSince1970)
        
        return NSDictionary(dictionary: dict)
    }
    
    func createTask(_ task: Task) {
        ref?.child("Task").child("\(task.id.uuidString)").setValue(convertToNSDictonary(task))
    }
    
    func fetchTasks() async {
        do {
            try await ref?.child("Task").getData()
        } catch {
            
        }
    }
}
