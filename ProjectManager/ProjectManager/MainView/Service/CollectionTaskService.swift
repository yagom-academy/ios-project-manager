//
//  CollectionTaskService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

final class CollectionTaskService {
    func fetchTaskList(for workState: WorkState) -> [Task] {
        return TaskRepository.shared.readTaskList(for: workState)
    }
    
    func removeTask(id: UUID) {
        TaskRepository.shared.remove(id: id)
    }
}
