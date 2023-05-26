//
//  MainCollectionViewService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

final class TaskStorageService {
    private let taskStore: [Task] = [
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hiThere", date: Date(), body: "body", workState: .done),
        Task(title: "hi", date: Date(), body: "body", workState: .doing),
    ]
    
    func createTask(_ task: Task) {
        
    }
    
    func fetchTaskList() -> [Task] {
        return taskStore
    }
    
    func updateTask(_ task: Task) {
        
    }
    
    func deleteTask(id: UUID) {
        
    }
}
