//
//  TaskManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation

final class TaskManager {
    static let shared = TaskManager()
    
    @Published private var todoList: [Task]
    @Published private var doingList: [Task]
    @Published private var doneList: [Task]
    
    private init() {
        todoList = []
        doingList = []
        doneList = []
    }
    
    func create(task: Task) {
        todoList.append(task)
    }
}
