//
//  TaskRepository.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

class LocalTaskRepository: TaskRepositoryProtocol {
    var taskDataStore = [UUID: TaskModelDTO]()
    
    func insertContent(entity: TaskModelDTO) {
        taskDataStore[entity["id"] as! UUID] = entity
    }
    
    func fetch() -> [TaskModelDTO] {
        return taskDataStore.map { $0.value }
    }
    
    func update(entity: TaskModelDTO) {
        taskDataStore.updateValue(entity, forKey: entity["id"] as! UUID)
    }
    
    func delete(id: UUID) {
        taskDataStore.removeValue(forKey: id)
    }
}
