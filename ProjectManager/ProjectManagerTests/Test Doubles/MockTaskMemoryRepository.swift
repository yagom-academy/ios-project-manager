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
    var mockTasks: [Task]
    var createdTask = [Task]()
    var updatedTask = [Task]()
    var deletedTask = [Task]()
    
    init(mockTasks: [Task]) {
        self.mockTasks = mockTasks
    }
    
    func create(with task: Task) {
        createdTask.append(task)
    }
    
    func fetchAll() -> [Task] {
        return mockTasks
    }
    
    func update(with task: Task) {
        updatedTask.append(task)
    }
    
    func delete(with task: Task) {
        deletedTask.append(task)
    }
}
