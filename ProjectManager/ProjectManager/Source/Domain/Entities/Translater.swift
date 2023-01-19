//
//  Translater.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import Foundation

struct Translater {
    func toDomain(with entity: TaskEntity) -> Task? {
        guard let state = Task.State(rawValue: entity.state) else {
            return nil
        }
        
        let task = Task(
            id: entity.id,
            title: entity.title,
            content: entity.content,
            deadLine: entity.deadLine,
            state: state
        )
        
        return task
    }
    
    func toEntity(with task: Task) -> TaskEntity {
        let entity = TaskEntity(
            id: task.id,
            title: task.title,
            content: task.content,
            deadLine: task.deadLine,
            state: task.state.rawValue
        )
        
        return entity
    }
}
