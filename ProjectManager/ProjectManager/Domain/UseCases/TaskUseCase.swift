//
//  TaskUseCase.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

struct TaskUseCase: TaskUseCaseProtocol {
    var repository: TaskRepositoryProtocol
    
    init(repository: TaskRepositoryProtocol) {
        self.repository = repository
    }
    
    func insertContent(task: Task) {
        var entity = TaskModelDTO()
        entity["id"] = task.id
        entity["title"] = task.title
        entity["body"] = task.body
        entity["date"] = task.date
        entity["state"] = task.state
        
        repository.insertContent(entity: entity)
    }
    
    func fetch() -> [Task] {
        let fetched: [TaskModelDTO] = repository.fetch()
        return fetched.map { Task(entity: $0) }
    }
    
    func update(task: Task) {
        var entity = TaskModelDTO()
        entity["id"] = task.id
        entity["title"] = task.title
        entity["body"] = task.body
        entity["date"] = task.date
        entity["state"] = task.state
        
        repository.update(entity: entity)
    }
    
    func delete(task: Task) {
        repository.delete(id: task.id)
    }
}
