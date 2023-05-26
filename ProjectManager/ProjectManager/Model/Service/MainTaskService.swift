//
//  MainCollectionViewService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

final class MainTaskService {
    func fetchTaskList() -> [Task] {
        return TaskRepository.shared.readAll()
    }
    
    func fetchTaskList(for workState: WorkState) -> [Task] {
        return TaskRepository.shared.readTaskList(for: workState)
    }
}
