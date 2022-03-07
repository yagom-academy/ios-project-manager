//
//  MockTaskMemoryRepository.swift
//  ProjectManagerTests
//
//  Created by 이차민 on 2022/03/07.
//

import Foundation
@testable import ProjectManager

extension Task: Equatable {
    public static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.deadline == rhs.deadline &&
               lhs.state == rhs.state
    }
}

class MockTaskMemoryRepository: TaskRepository {
    var mockTasks = [UUID: Task]()
    
    func create(with task: Task) {
        mockTasks[task.id] = task
    }
    
    func fetchAll() -> [Task] {
        return mockTasks.map { $0.value }
    }
    
    func update(with task: Task) {
        mockTasks.updateValue(task, forKey: task.id)
    }
    
    func delete(with task: Task) {
        mockTasks.removeValue(forKey: task.id)
    }
}
