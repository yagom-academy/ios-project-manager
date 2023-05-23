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
    
    @Published private var taskList: [Task] = []
    
    private init() { }
    
    func taskListPublisher() -> AnyPublisher<[Task], Never> {
        return $taskList.eraseToAnyPublisher()
    }
    
    func create(task: Task) {
        taskList.append(task)
    }
    
    func update(task: Task) {
        let index = taskList.firstIndex { $0.id == task.id }
        guard let index else { return }
        
        taskList[index] = task
    }
    
    func delete(by id: UUID) {
        taskList.removeAll { $0.id == id }
    }
}
