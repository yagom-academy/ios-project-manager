//
//  TaskStore.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/04.
//

import Foundation

class TaskStore {
    var todoTask: [Task]
    var doingTask: [Task]
    var doneTask: [Task]
    
    static let shared = TaskStore()
    
    private init() {
        todoTask = []
        doingTask = []
        doneTask = []
    }
}
