//
//  ContentViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @ObservedObject var data = TaskViewModel()
    @Published var todoTasks: [Task] = []
    @Published var doingTasks: [Task] = []
    @Published var doneTasks: [Task] = []
    
    func appendData() {
        data.addTask()
        if let task = data.taskArray.last {
            todoTasks.append(task)
        }
    }
    
    func moveData(_ task: Task, from: TaskType, to: TaskType) {
        switch from {
        case .todo:
            if let taskToDelete = todoTasks.firstIndex(of: task) {
                todoTasks.remove(at: taskToDelete)
            }
        case .doing:
            if let taskToDelete = doingTasks.firstIndex(of: task) {
                doingTasks.remove(at: taskToDelete)
            }
        case .done:
            if let taskToDelete = doneTasks.firstIndex(of: task) {
                doneTasks.remove(at: taskToDelete)
            }
        }
        
        switch to {
        case .todo:
            todoTasks.append(task)
        case .doing:
            doingTasks.append(task)
        case .done:
            doneTasks.append(task)
        }
    }
}
