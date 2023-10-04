//
//  RealmRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/03.
//

import Foundation
import RealmSwift

final class LocalTaskRepository: TaskRepository {
    
    private let realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("could not load REALM")
        }
    }()
    
    func fetchAll() -> [Task] {
        let taskObjects = realm.objects(TaskObject.self).sorted(by: \.date)
        let tasks = Array(taskObjects).map{ $0.toDomain() }
        
        return tasks
    }
    
    func save(_ task: Task) {
        try? realm.write {
            realm.add(task.toObject())
        }
    }
    
    func update(id: UUID, new task: Task) {
        try? realm.write {
            let taskObject = realm.object(ofType: TaskObject.self, forPrimaryKey: id)
            taskObject?.title = task.title
            taskObject?.content = task.content
            taskObject?.date = task.date
            taskObject?.state = task.state.rawValue
        }
    }
    
    func delete(task: Task) {
        if let taskObject = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) {
            try? realm.write {
                realm.delete(taskObject)
            }
        }
    }
    
    func fetch(id: UUID) -> Task? {
        let taskObject = realm.object(ofType: TaskObject.self, forPrimaryKey: id)
        return taskObject?.toDomain()
    }
}


