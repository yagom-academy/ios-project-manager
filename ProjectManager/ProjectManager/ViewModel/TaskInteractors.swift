//
//  TaskService.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/07.
//

import Foundation

struct TaskInteractors {
    let taskStorage: TaskStorage
    let appState: AppState

    init(taskStorage: TaskStorage, appState: AppState) {
        self.taskStorage = taskStorage
        self.appState = appState
    }
    
    func createTask() {
        
    }
    
    func updateTask() {
        
    }
    
    func deleteTask() {
        
    }
    
}
