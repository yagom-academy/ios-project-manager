//
//  TaskViewModel.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/07.
//

import Foundation

class TaskViewModel: ObservableObject {
    private let enviroment = TaskEnvironment(taskRepository: TaskRepository())
    
    @Published var tasks: [Task]
    
    var todoTasks: [Task] {
        return tasks.filter { $0.status == .todo }
    }
    
    var doingTasks: [Task] {
        return tasks.filter { $0.status == .doing }
    }
    
    var doneTasks: [Task] {
        return tasks.filter { $0.status == .done }
    }
    
    init() {
        tasks = enviroment.getTaskList()
    }
    
    func createTask(title: String, content: String, limitDate: Date) {
        let task = Task(title: title, content: content, limitDate: limitDate, status: .todo)
        enviroment.createTask(task)
        tasks = enviroment.getTaskList()
    }
    
    func updateTask(task: Task, title: String, content: String, limitDate: Date) {
        task.title = title
        task.content = content
        task.limitDate = limitDate
        enviroment.updateTask(task, title: title, content: content, limitDate: limitDate)
    }
    
    func deleteTask(task: Task) {
        enviroment.deleteTask(task)
        tasks = enviroment.getTaskList()
    }
    
    func changeStatus(task: Task, to taskStatus: TaskStatus) {
        task.status = taskStatus
    }
}
