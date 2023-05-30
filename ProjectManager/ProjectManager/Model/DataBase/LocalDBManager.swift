//
//  LocalDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

protocol DatabaseManagable {
    func createTask(_ task: Task)
    func fetchTasks(_ completion: @escaping (Result<[Task], Error>) -> Void)
    func deleteTask(_ task: Task)
    func updateTask(_ task: Task)
}

import RealmSwift

final class LocalDBManager: DatabaseManagable {
    private let realm: Realm
    private lazy var remoteManager = RemoteDBManager()
    
    init?() {
        do {
            self.realm = try Realm()
        } catch {
            return nil
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
    
    func createTask(_ task: Task) {
        let taskObject = changeToTaskObject(task)
        
        try? realm.write({
            realm.add(taskObject, update: .all)
            remoteManager.createTask(task)
        })
    }
    
    func fetchTasks(_ completion: @escaping (Result<[Task], Error>) -> Void) {
        let taskObjects = realm.objects(TaskObject.self)
        
        let tasks = taskObjects.map { taskObject in
            return self.changeToTask(taskObject)
        }
        
        completion(.success(Array(tasks)))
    }
    
    func updateTask(_ task: Task) {
        guard let taskObject = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) else {
            return
        }
        
        try? realm.write {
            taskObject.setValue(task.title, forKey: "title")
            taskObject.setValue(task.description, forKey: "desc")
            taskObject.setValue(task.date, forKey: "date")
            taskObject.setValue(task.state?.titleText, forKey: "state")
        }
    }
    
    func deleteTask(_ task: Task) {
        guard let taskObject = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) else {
            return
        }
        
        try? realm.write({
            realm.delete(taskObject)
        })
    }
}
