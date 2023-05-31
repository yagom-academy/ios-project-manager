//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation
import Combine

final class TaskListViewModel {
    @Published var taskList: [MyTask] = []
    private let state: TaskState
    private let projectManagerService = ProjectManagerService.shared
    private var subscribes = Set<AnyCancellable>()
    
    var firstPopoverActionTitle: String? {
        guard let actionTitle = state.others.first?.description else { return nil }
        
        return "Move to \(actionTitle)"
    }
    
    var secondPopoverActionTitle: String? {
        guard let actionTitle = state.others.second?.description else { return nil }
        
        return "Move to \(actionTitle)"
    }
    
    init(state: TaskState) {
        self.state = state
        
        requestFilteredTaskList()
    }
    
    func delete(indexPath: IndexPath) {
        guard let task = taskList[safe: indexPath.row] else { return }
        
        projectManagerService.delete(task)
    }
    
    func changeState(indexPath: IndexPath, targetState: TaskState?) {
        guard var task = taskList[safe: indexPath.row],
              let targetState else { return }
        
        let currentState = task.state
        task.state = targetState
        
        projectManagerService.move(task, from: currentState, to: targetState)
    }
    
    private func requestFilteredTaskList() {
        projectManagerService.requestTaskListPublisher()
            .map {
                $0.filter { [weak self] task in
                    task.state == self?.state
                }
            }
            .assign(to: \.taskList, on: self)
            .store(in: &subscribes)
    }
}
