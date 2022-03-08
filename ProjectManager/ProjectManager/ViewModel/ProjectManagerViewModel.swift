//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/06.
//

import SwiftUI

final class ProjectManagerViewModel: ObservableObject {
    
    @Published private var model = TaskMemoryManager(tasks: projectTasks)
    
    var todoTasks: [Task] {
        model.todoTasks
    }
    
    var doingTasks: [Task] {
        model.doingTasks
    }
    
    var doneTasks: [Task] {
        model.doneTasks
    }
    
    func create(title: String, description: String, dueDate: Date) {
        let newTask = Task(
            id: UUID(),
            title: title,
            description: description,
            dueDate: dueDate,
            status: .todo
        )
        try? model.create(newTask)
    }
    
    func remove(_ task: Task) {
        try? model.delete(task)
    }
    
    func remove(_ tasks: [Task]) {
        tasks.forEach { task in
            remove(task)
        }
    }
    
    func update(_ task: Task,
                title: String? = nil, description: String? = nil, dueDate: Date? = nil,
                taskStatus: TaskStatus? = nil) {
        let newTask = Task(
            id: task.id,
            title: title ?? task.title,
            description: description ?? task.description,
            dueDate: dueDate ?? task.dueDate,
            status: taskStatus ?? task.status
        )
        try? model.update(task, to: newTask)
    }
    
}

extension ProjectManagerViewModel {
    
    static let projectTasks = [
        Task(id: UUID(), title: "Hello", description: "World", dueDate: Date(), status: .todo),
        Task(id: UUID(), title: "My Name Is", description: "New Task", dueDate: Date(), status: .doing),
        Task(id: UUID(), title: "Nice to", description: "Meet You", dueDate: Date(), status: .done),
        Task(id: UUID(), title: "I Love", description: "Camel Case", dueDate: Date(), status: .todo)
    ]
    
}
