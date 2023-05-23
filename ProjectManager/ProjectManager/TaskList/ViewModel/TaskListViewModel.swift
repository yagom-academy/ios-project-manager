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
    @Published var taskList: [Task] = []
    private var subscribes = Set<AnyCancellable>()
    
    init(state: State) {
        self.state = state
        
        requestFilteredTaskList()
    }
    
    private func requestFilteredTaskList() {
        taskManager.taskListPublisher()
            .map {
                $0.filter { [weak self] task in
                    task.state == self?.state
                }
            }
            .assign(to: \.taskList, on: self)
            .store(in: &subscribes)
    }
    
    func delete(indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        
        taskManager.delete(by: task.id)
    }
}
