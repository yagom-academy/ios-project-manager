//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

class TaskRepository: TaskRepositoryProtocol {
    var data = [UUID: TaskModelDTO]()
    
    func insertContent(model: TaskModelDTO) {
        data[model.id] = model
    }
    
    func fetch() -> [TaskModelDTO] {
        return data.map { $0.value }
    }
    
    func update(model: TaskModelDTO) {
        data.updateValue(model, forKey: model.id)
    }
    
    func delete(model: TaskModelDTO) {
        data.removeValue(forKey: model.id)
    }
}

