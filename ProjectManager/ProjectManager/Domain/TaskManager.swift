//
//  TaskManager.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

final class TaskManager: TaskMangeable {
    let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func create(with task: Task) {
        taskRepository.create(with: task)
    }
    
    func fetchAll() -> [Task] {
        let tasks = taskRepository.fetchAll()
        return tasks.sorted { $0.deadline < $1.deadline }
    }
    
    func fetch(at index: Int, with state: TaskState) -> Task? {
        let tasks = taskRepository.fetchAll()
        let filteredTasks = tasks.filter { $0.state == state }
        return filteredTasks[safe: index]
    }
    
    func update(with task: Task) {
        taskRepository.update(with: task)
    }
    
    func delete(with task: Task) {
        taskRepository.delete(with: task)
    }
    
    func changeState(of task: Task, to state: TaskState) {
        let taskToChange = Task(id: task.id,
                        title: task.title,
                        description: task.description,
                        deadline: task.deadline,
                        state: state)
        
        taskRepository.update(with: taskToChange)
    }
}
