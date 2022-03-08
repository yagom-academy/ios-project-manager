//
//  ProjectManagerEnvironment.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import Foundation

struct ProjectManagerEnvironment {
    var taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    func getTaskList() -> [Task] {
        return taskRepository.tasks.map { $0.toViewModel() }
    }
    
    func createTask(task: Task) {
        let taskEntity = TaskEntity(from: task)
        taskRepository.insert(taskEntity)
    }
    
    func updateTask(task: Task, title: String, content: String, limitDate: Date) {
        let taskEntity = taskRepository.tasks.filter { $0.id == task.id }.first
        do {
            try taskRepository.update(task: taskEntity, title: title, content: content, date: limitDate)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(task: Task) {
        let taskEntity = taskRepository.tasks.filter { $0.id == task.id }.first
        do {
            try taskRepository.delete(task: taskEntity)
        } catch {
            print(error.localizedDescription)
        }
    }
}
