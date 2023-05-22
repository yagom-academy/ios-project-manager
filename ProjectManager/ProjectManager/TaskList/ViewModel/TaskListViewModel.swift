//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation
import Combine

final class TaskListViewModel {
    private let state: State
    private let taskManager = TaskManager.shared
    
    init(state: State) {
        self.state = state
    }
    
    func filteredTaskPublisher() -> AnyPublisher<[Task], Never> {
        return taskManager.taskListPublisher()
            .map {
                $0.filter { [weak self] task in
                    task.state == self?.state
                }
            }
            .eraseToAnyPublisher()
    }
}
