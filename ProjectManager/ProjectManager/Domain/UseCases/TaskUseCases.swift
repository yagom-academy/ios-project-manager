//
//  TaskUseCases.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import Foundation

final class TaskUseCases {
    private let taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func fetchTasks() -> [Task] {
        taskRepository.fetchAll()
    }
    
    func createTask(_ task: Task) {
        taskRepository.save(task)
    }
    
    func updateTask(id: UUID, new task: Task) {
        taskRepository.update(id: id, new: task)
    }
    
    func deleteTask(_ task: Task) {
        taskRepository.delete(task: task)
    }
    
    func moveTask(task: Task, to taskState: TaskState) {
        var copiedTask = task
        copiedTask.state = taskState
        taskRepository.update(id: task.id, new: copiedTask)
    }
}
