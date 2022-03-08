//
//  TaskService.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/07.
//

import Foundation

class TaskService: ObservableObject {
    @Published var taskStorage = TaskRepository()
    
    func createTask(title: String, content: String, date: Date) {
        let task = TaskEntity(
            title: title,
            content: content,
            limitDate: date,
            status: .todo,
            statusModifiedDate: Date().timeIntervalSince1970
        )
        taskStorage.insert(task)
    }
    
    func deleteTask(task: TaskEntity?) {
        taskStorage.delete(task: task)
    }
}
