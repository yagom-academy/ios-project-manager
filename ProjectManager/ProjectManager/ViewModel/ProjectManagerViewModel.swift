//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/07.
//

import Foundation

class ProjectManagerViewModel: ObservableObject {
    let enviroment = ProjectManagerEnvironment(taskRepository: TaskRepository())
    
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
        tasks.insert(task, at: 0)
        enviroment.createTask(task)
    }
    
    func updateTask(task: Task, title: String, content: String, limitDate: Date) {
        task.title = title
        task.content = content
        task.limitDate = limitDate
        enviroment.updateTask(task, title: title, content: content, limitDate: limitDate)
    }
    
    func deleteTask(task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        tasks.remove(at: index)
        enviroment.deleteTask(task)
    }
    
    func changeStatus(task: Task, to taskStatus: TaskStatus) {
        task.status = taskStatus
    }
}
