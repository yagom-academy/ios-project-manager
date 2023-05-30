//
//  LocalDBManager.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/29.
//

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
