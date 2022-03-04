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
        return taskRepository.fetchAll()
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
