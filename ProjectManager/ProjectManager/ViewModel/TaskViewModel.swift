//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/07.
//

import Foundation

class TaskViewModel: ObservableObject {
    private var taskRepository: TaskRepository
    @Published var tasks: [Task]
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        tasks = taskRepository.tasks.map { $0.toViewModel() }
    }

    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }
    }
    
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }
    }
    
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }
    }
    
    func getTaskList() -> [Task] {
        return taskRepository.tasks.map { $0.toViewModel() }
    }
    
    func createTask(title: String, content: String, limitDate: Date) {
        let task = Task(title: title, content: content, limitDate: limitDate, status: .todo)
        let taskEntity = TaskEntity(from: task)
        taskRepository.insert(taskEntity)
        tasks = getTaskList()
    }
    
    func updateTask(taskID: UUID, title: String, content: String, limitDate: Date) {
        let taskEntity = taskRepository.tasks.filter { $0.id == taskID }.first
        do {
            try taskRepository.update(task: taskEntity, title: title, content: content, date: limitDate)
        } catch {
            print(error.localizedDescription)
        }
        tasks = getTaskList()
    }
    
    func deleteTask(taskID: UUID) {
        let taskEntity = taskRepository.tasks.filter { $0.id == taskID }.first
        do {
            try taskRepository.delete(task: taskEntity)
        } catch {
            print(error.localizedDescription)
        }
        tasks = getTaskList()
    }
    
    func changeStatus(taskID: UUID, to taskStatus: TaskStatus) {
        let taskEntity = taskRepository.tasks.filter { $0.id == taskID }.first
        do {
            try taskRepository.changeStatus(task: taskEntity, taskStatus)
        } catch {
            print(error.localizedDescription)
        }
        tasks = getTaskList()
    }
}
