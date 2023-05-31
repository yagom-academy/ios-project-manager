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
    
    private init() { }
    
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
//        historyManager.createAddedHistory(title: task.title)
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
//        historyManager.createMovedHistory(title: task.title,
//                                          from: currentState,
//                                          to: targetState)
    }
    
    func delete(_ task: MyTask) {
        taskManager.delete(task)
        
        let history = historyManager.getRemovedHistory(title: task.title, from: task.state)
        
        historyManager.create(history)
    }
}
