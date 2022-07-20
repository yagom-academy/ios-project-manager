//
//  PopoverButtonViewModel.swift
//  ProjectManager
//
//  Created by marisol on 2022/07/20.
//

import Foundation
import SwiftUI

class PopoverButtonViewModel: ObservableObject {
    @ObservedObject var allListViewModel = AllListViewModel()
    
    func moveData(_ task: Task, from: TaskType, to: TaskType) {
        switch from {
        case .todo:
            if let taskToDelete = allListViewModel.todoTasks.firstIndex(of: task) {
                allListViewModel.todoTasks.remove(at: taskToDelete)
            }
        case .doing:
            if let taskToDelete = allListViewModel.doingTasks.firstIndex(of: task) {
                allListViewModel.doingTasks.remove(at: taskToDelete)
            }
        case .done:
            if let taskToDelete = allListViewModel.doneTasks.firstIndex(of: task) {
                allListViewModel.doneTasks.remove(at: taskToDelete)
            }
        }
        
        switch to {
        case .todo:
            allListViewModel.todoTasks.append(task)
        case .doing:
            allListViewModel.doingTasks.append(task)
        case .done:
            allListViewModel.doneTasks.append(task)
        }
    }
}
