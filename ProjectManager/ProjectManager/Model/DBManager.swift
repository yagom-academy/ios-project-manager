//
//  DBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

import Foundation
import RealmSwift
import Realm

class TaskObject: Object {
    dynamic var id: UUID = UUID()
    dynamic var title: String = ""
    dynamic var desc: String = ""
    dynamic var date: Date = Date()
    dynamic var state: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class DBManager {
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Error Realm")
        }
    }
    
    private func changeToTaskObject(_ task: Task) -> TaskObject {
        let taskObject = TaskObject()
        taskObject.id = task.id
        taskObject.title = task.title
        taskObject.desc = task.description
        taskObject.date = task.date
        taskObject.state = task.state?.titleText
        
        return taskObject
    }
    
    private func changeToTask(_ taskObject: TaskObject) -> Task {
        let task = Task(id: taskObject.id,
                        title: taskObject.title,
                        description: taskObject.desc,
                        date: taskObject.date,
                        state: TaskState.checkTodoState(by: taskObject.state ?? ""))
        
        return task
    }
    
    func addTask(by task: Task) {
        let taskObject = changeToTaskObject(task)
        
        try? realm.write({
            realm.add(taskObject, update: .all)
        })
    }
    
    func searchAllTask() {
        let taskObjects = realm.objects(TaskObject.self)
        
        let tasks = taskObjects.map { taskObject in
            return self.changeToTask(taskObject)
        }
    }
}
