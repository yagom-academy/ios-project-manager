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
    
    func fetch(at index: Int, from state: TaskState) -> Task? {
        let tasks = fetchAll()
        let filteredTasks = tasks.filter { $0.state == state }
        return filteredTasks[safe: index]
    }
    
    func update(at index: Int, from state: TaskState) {
        guard let selectedTask = fetch(at: index, from: state) else {
            return
        }
        
        taskRepository.update(with: selectedTask)
    }
    
    func delete(at index: Int, from state: TaskState) {
        guard let selectedTask = fetch(at: index, from: state) else {
            return
        }
        
        taskRepository.delete(with: selectedTask)
    }
    
    func changeState(at index: Int, to state: TaskState) {
        guard let selectedTask = fetch(at: index, from: state) else {
            return
        }
        
        let taskToChange = Task(id: selectedTask.id,
                        title: selectedTask.title,
                        description: selectedTask.description,
                        deadline: selectedTask.deadline,
                        state: state)
        
        taskRepository.update(with: taskToChange)
    }
}
