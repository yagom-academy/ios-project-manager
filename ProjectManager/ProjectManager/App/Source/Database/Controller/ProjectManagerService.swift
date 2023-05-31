//
//  ProjectManagerService.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/31.
//

import Foundation
import Combine

final class ProjectManagerService {
    static let shared = ProjectManagerService()
    
    let taskManager = TaskManager()
    let historyManager = HistoryManager()
    
    private init() { }
    
    func requestTaskListPublisher() -> AnyPublisher<[MyTask], Never> {
        return taskManager.requestTaskListPublisher()
    }
    
    func requestHistoryList() -> [History] {
        return historyManager.historyList
    }
    
    func create(_ task: MyTask) {
        taskManager.create(task)
        historyManager.createAddedHistory(title: task.title)
    }
    
    func update(_ task: MyTask) {
        taskManager.update(task)
    }
    
    func move(_ task: MyTask, from currentState: TaskState, to targetState: TaskState) {
        taskManager.update(task)
        historyManager.createMovedHistory(title: task.title,
                                          from: currentState,
                                          to: targetState)
    }
    
    func delete(_ task: MyTask) {
        taskManager.delete(task)
        historyManager.createRemovedHistory(title: task.title, from: task.state)
    }
}
