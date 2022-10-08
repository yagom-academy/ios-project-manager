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
    
    @Published var shouldShowErrorAlert = false
}

extension TasksDataSource {
    
    func replaceOriginalTask(with selectedTask: Task) {
        switch selectedTask.status {
        case .todo:
            let index = todoTasks.firstIndex { $0.id == selectedTask.id }
            
            guard let index = index else {
                requestErrorHandling(on: .replaceOriginalTask)
                return
            }
            
            todoTasks[index] = selectedTask
        case .doing:
            let index = doingTasks.firstIndex { $0.id == selectedTask.id }
            
            guard let index = index else {
                requestErrorHandling(on: .replaceOriginalTask)
                return
            }
            
            doingTasks[index] = selectedTask
        case .done:
            let index = doneTasks.firstIndex { $0.id == selectedTask.id }
            
            guard let index = index else {
                requestErrorHandling(on: .replaceOriginalTask)
                return
            }
            
            doneTasks[index] = selectedTask
        }
    }
    
    func deleteOriginalTask(equivalentTo selectedTask: Task) {
        switch selectedTask.status {
        case .todo:
            let index = todoTasks.firstIndex { $0.id == selectedTask.id }
            
            guard let index = index else {
                requestErrorHandling(on: .deleteOriginalTask)
                return
            }
            
            todoTasks.remove(at: index)
        case .doing:
            let index = doingTasks.firstIndex { $0.id == selectedTask.id }
            
            guard let index = index else {
                requestErrorHandling(on: .deleteOriginalTask)
                return
            }
            
            doingTasks.remove(at: index)
        case .done:
            let index = doneTasks.firstIndex { $0.id == selectedTask.id }
            
            guard let index = index else {
                requestErrorHandling(on: .deleteOriginalTask)
                return
            }
            
            doneTasks.remove(at: index)
        }
    }

    func transfer(selectedTask: Task, to newCategory: Status) {
        deleteOriginalTask(equivalentTo: selectedTask)
        
        switch newCategory {
        case .todo:
            let newTask = newTask(copiedFrom: selectedTask, withNewStatus: .todo)
            todoTasks.append(newTask)
        case .doing:
            let newTask = newTask(copiedFrom: selectedTask, withNewStatus: .doing)
            doingTasks.append(newTask)
        case .done:
            let newTask = newTask(copiedFrom: selectedTask, withNewStatus: .done)
            doneTasks.append(newTask)
        }
    }
}

private extension TasksDataSource {
    
    func newTask(copiedFrom originalTask: Task, withNewStatus newStatus: Status) -> Task {
        let taskWithNewStatus = Task(
            title: originalTask.title,
            description: originalTask.description,
            dueDate: originalTask.dueDate,
            status: newStatus
        )
        
        return taskWithNewStatus
    }
    
    func requestErrorHandling(on error: LogicError) {
        ErrorAlertManager.recieve(error)
        shouldShowErrorAlert.toggle()
    }
}
