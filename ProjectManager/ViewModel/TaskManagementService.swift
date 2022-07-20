//
//  SomeViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import SwiftUI

class TaskManagementService {
    @ObservedObject var taskViewModel = TaskViewModel()
    @ObservedObject var allListViewModel = AllListViewModel()
    
    // CREATE
    func appendData() {
        taskViewModel.addTask(title: taskViewModel.title, date: taskViewModel.date, body: taskViewModel.body)
        if let task = taskViewModel.taskArray.last {
            allListViewModel.todoTasks.append(task)
        }
    }
    
    // READ
    
    // UPDATE
    
    // DELETE
}
