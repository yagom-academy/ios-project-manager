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
    private let taskManager = TaskManager.shared
    private var subscribes = Set<AnyCancellable>()
    
    var firstPopoverActionTitle: String {
        return "Move to \(state.others.first.description)"
    }
    
    var secondPopoverActionTitle: String {
        return "Move to \(state.others.second.description)"
    }
    
    init(state: TaskState) {
        self.state = state
        
        requestFilteredTaskList()
    }
    
    func delete(indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        
        taskManager.delete(by: task.id)
    }
    
    func changeState(indexPath: IndexPath, state: TaskState) {
        var task = taskList[indexPath.row]
        task.state = state
        
        taskManager.update(task: task)
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
}
