//
//  MemoryRepository.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

final class MemoryRepository: Repository {
    private var tasks = [UUID: Task]()
    
    func create(with task: Task) {
        tasks[task.id] = task
    }
    
    func fetchAll() -> [Task] {
        return tasks.map { $0.value }
    }
    
    func update(with task: Task) {
        tasks.updateValue(task, forKey: task.id)
    }
    
    func delete(with task: Task) {
        tasks.removeValue(forKey: task.id)
    }
}
