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
    
    private let taskManager = TaskManager()
    private let historyManager = HistoryManager()
    private let networkMonitor = NetworkMonitor.shared
    
    private init() { }
    
    func isNetworkConnectedPublisher() -> AnyPublisher<Bool, Never> {
        return networkMonitor.$isConnected.eraseToAnyPublisher()
    }
    
    func requestTaskListPublisher() -> AnyPublisher<[MyTask], Never> {
        return taskManager.requestTaskListPublisher()
    }
    
    func requestHistoryList() -> [History] {
        return historyManager.historyList
    }
    
    func create(_ task: MyTask) {
        taskManager.create(task)
        
        let history =  historyManager.getAddedHistory(title: task.title)
        
        historyManager.create(history)
    }
    
    func update(_ task: MyTask) {
        taskManager.update(task)
    }
    
    func move(_ task: MyTask, from currentState: TaskState, to targetState: TaskState) {
        taskManager.update(task)
        
        let history = historyManager.getMovedHistory(title: task.title,
                                                        from: currentState,
                                                        to: targetState)
        historyManager.create(history)
    }
    
    func delete(_ task: MyTask) {
        taskManager.delete(task)
        
        let history = historyManager.getRemovedHistory(title: task.title, from: task.state)
        
        historyManager.create(history)
    }
}
