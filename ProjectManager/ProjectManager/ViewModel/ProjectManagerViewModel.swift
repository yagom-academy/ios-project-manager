//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/06.
//

import SwiftUI

final class ProjectManagerViewModel: ObservableObject {
    
    @Published private var model = TaskMemoryManager(tasks: projectTasks)
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        return formatter
    }()
    
    var todoTasks: [Task] {
        model.todoTasks
    }
    
    var doingTasks: [Task] {
        model.doingTasks
    }
    
    var doneTasks: [Task] {
        model.doneTasks
    }
    
    func findTasks(of type: TaskStatus) -> [Task] {
        switch type {
        case .todo:
            return todoTasks
        case .doing:
            return doingTasks
        case .done:
            return doneTasks
        }
    }
    
    func formatDueDate(of task: Task) -> String {
        return dateFormatter.string(from: task.dueDate)
    }
    
    func isValid(task: Task) -> Bool {
        let calendar = Calendar.current
        let today = Date()
        guard let yesterday = calendar.date(
            byAdding: .day, value: -1, to: today) else {
            return false
        }
        return task.dueDate < yesterday && task.status != .done
    }
    
    func create(title: String, description: String, dueDate: Date) throws {
        let newTask = Task(
            id: UUID(),
            title: title,
            description: description,
            dueDate: dueDate,
            status: .todo
        )
        try model.create(newTask)
    }
    
    func remove(_ task: Task) throws {
        try model.delete(task)
    }
    
    func remove(_ tasks: [Task]) throws {
        for task in tasks {
            try remove(task)
        }
    }
    
    func update(_ task: Task,
                title: String? = nil, description: String? = nil, dueDate: Date? = nil,
                taskStatus: TaskStatus? = nil) throws {
        let newTask = Task(
            id: task.id,
            title: title ?? task.title,
            description: description ?? task.description,
            dueDate: dueDate ?? task.dueDate,
            status: taskStatus ?? task.status
        )
        try model.update(task, to: newTask)
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
