//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

final class TaskRepository {
    static let shared = TaskRepository()
    private init() { }
    
    private var storage: [Task] =  [
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hiThere", date: Date(), body: "body", workState: .done),
        Task(title: "hi", date: Date(), body: "body", workState: .doing),
    ]
    
    func append(_ task: Task) {
        storage.append(task)
    }
    
    func readAll() -> [Task] {
        return storage
    }
    
    func update(task: Task) {
        let targetIndex = storage.firstIndex { $0.id == task.id }
        guard let targetIndex else { return }
        
        storage[targetIndex] = task
    }
    
    func delete(task: Task) {
        let targetIndex = storage.firstIndex { $0.id == task.id }
        guard let targetIndex else { return }
        
        storage.remove(at: targetIndex)
    }
}
