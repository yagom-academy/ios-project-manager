//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

final class TaskManager: TaskMangeable {
    var repository: Repository
    
    required init(repository: Repository) {
        self.repository = repository
    }
    
    func create(with task: Task) {
        repository.create(with: task)
    }
    
    func fetchAll() -> [Task] {
        return repository.fetchAll()
    }
    
    func update(with task: Task) {
        repository.update(with: task)
    }
    
    func delete(with task: Task) {
        repository.delete(with: task)
    }
    
    func changeState(of task: Task, to state: TaskState) {
        let taskToChange = Task(id: task.id,
                        title: task.title,
                        description: task.description,
                        deadline: task.deadline,
                        state: state)
        
        repository.update(with: taskToChange)
    }
}
