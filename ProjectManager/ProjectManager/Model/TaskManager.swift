//
//  TaskManager.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/22.
//

import Foundation
import Combine

final class TaskManager {
    static let shared = TaskManager()
    
    @Published private var taskList: [Task]
    
    private init() {
        taskList = [Task(state: .done, title: "test", body: "test", deadline: Date())]
    }
    
    func taskListPublisher() -> AnyPublisher<[Task], Never> {
        return $taskList.eraseToAnyPublisher()
    }
    
    func create(task: Task) {
        taskList.append(task)
    }
    
    func fetch() -> [Task] {
        return taskList
    }
}
