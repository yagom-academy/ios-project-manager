//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/20.
//

import UIKit

struct TaskRepository {
    
    private let decoder = JSONDecoder()
    
    func fetchTasks() throws -> [Task] {
        guard let asset = NSDataAsset(name: "tasks") else { return [] }
        let tasks = try decoder.decode([Task].self, from: asset.data)
        
        return tasks
    }
}
