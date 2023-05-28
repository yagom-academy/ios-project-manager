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
    
    @Published private var taskList: [MyTask] = []
    
    private init() { }
    
    func taskListPublisher() -> AnyPublisher<[MyTask], Never> {
        return $taskList.eraseToAnyPublisher()
    }
    
    func create(task: MyTask) {
        taskList.append(task)
    }
    
    func update(task: MyTask) {
        guard let index = taskList.firstIndex(where: { $0.id == task.id }) else { return }
        
        taskList[safe: index] = task
    }
    
    func delete(by id: UUID) {
        taskList.removeAll { $0.id == id }
    }
}
