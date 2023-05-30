//
//  RemoteDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/30.
//

import FirebaseDatabase

final class RemoteDBManager {
    let ref = Database.database().reference()
    
    func updateDatas(_ tasks: [Task]) {
        tasks.forEach { task in
            ref.child("Task").child("\(task.id.uuidString)").setValue(task.title, forKey: "title")
            ref.child("Task").child("\(task.id.uuidString)").setValue(task.description, forKey: "desc")
            ref.child("Task").child("\(task.id.uuidString)").setValue(task.state?.titleText, forKey: "state")
            ref.child("Task").child("\(task.id.uuidString)").setValue(task.date, forKey: "date")
        }
    }
}
