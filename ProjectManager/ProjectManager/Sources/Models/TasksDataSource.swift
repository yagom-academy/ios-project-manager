//
//  TaskDashboardViewModel.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import Foundation

final class TasksDataSource: ObservableObject {
    
    @Published var todoTasks: [Task] = [
        //TODO: 더미데이터 추후 삭제
        Task(title: "Title 1", description: "Description 1", dueDate: Date.now, status: .todo),
        Task(title: "Title 2", description: "Description 2", dueDate: Date.now, status: .todo),
        Task(title: "Title 3", description: "Description 3", dueDate: Date.now, status: .todo)
    ]
    
    @Published var doingTasks: [Task] = [
        //TODO: 더미데이터 추후 삭제
        Task(title: "Title 1", description: "Description 1", dueDate: Date.now, status: .doing),
        Task(title: "Title 2", description: "Description 2", dueDate: Date.now, status: .doing),
        Task(title: "Title 3", description: "Description 3", dueDate: Date.now, status: .doing)
    ]
    
    @Published var doneTasks: [Task] = [
        //TODO: 더미데이터 추후 삭제
        Task(title: "Title 1", description: "Description 1", dueDate: Date.now, status: .done),
        Task(title: "Title 2", description: "Description 2", dueDate: Date.now, status: .done),
        Task(title: "Title 3", description: "Description 3", dueDate: Date.now, status: .done)
    ]
    
    func replaceOriginalTask(with selectedTask: Task) {
        switch selectedTask.status {
        case .todo:
            let index = todoTasks.firstIndex { $0.id == selectedTask.id }
            
            if let index = index {
                todoTasks[index] = selectedTask
            }
        case .doing:
            let index = doingTasks.firstIndex { $0.id == selectedTask.id }
            
            if let index = index {
                doingTasks[index] = selectedTask
            }
        case .done:
            let index = doneTasks.firstIndex { $0.id == selectedTask.id }
            
            if let index = index {
                doneTasks[index] = selectedTask
            }
        }
    }
}
