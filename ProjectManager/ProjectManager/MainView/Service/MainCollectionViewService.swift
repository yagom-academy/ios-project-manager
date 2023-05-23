//
//  MainCollectionViewService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

final class MainCollectionViewService {
    func fetchTaskList() -> [Task] {
        return TaskRepository.shared.readAll()
    }
}
