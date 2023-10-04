//
//  TaskUseCases.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import Foundation

final class TaskUseCases {
    private let appState: AppState
    private let localTaskRepository: TaskRepository
    private let remoteTaskRepositoty: TaskRepository
    
    init(
        appState: AppState,
        localRepository: TaskRepository,
        remoteRepository: TaskRepository
    ) {
        self.appState = appState
        self.localTaskRepository = localRepository
        self.remoteTaskRepositoty = remoteRepository
    }
    
    func fetchTasks() -> [Task] {
        let tasksFromLocal = localTaskRepository.fetchAll()
        
        if tasksFromLocal.isEmpty && appState.isConnectedRemoteServer {
            return remoteTaskRepositoty.fetchAll()
        } else {
            return tasksFromLocal
        }
    }
    
    func createTask(_ task: Task) {
        localTaskRepository.save(task)
        
        if appState.isConnectedRemoteServer {
            remoteTaskRepositoty.save(task)
        }
    }
    
    func updateTask(id: UUID, new task: Task) {
        localTaskRepository.update(id: id, new: task)
        
        if appState.isConnectedRemoteServer {
            remoteTaskRepositoty.update(id: id, new: task)
        }
    }
    
    func deleteTask(_ task: Task) {
        localTaskRepository.delete(task: task)
        
        if appState.isConnectedRemoteServer {
            remoteTaskRepositoty.delete(task: task)
        }
    }
    
    func moveTask(task: Task, to taskState: TaskState) {
        var copiedTask = task
        copiedTask.state = taskState
        localTaskRepository.update(id: task.id, new: copiedTask)
        
        if appState.isConnectedRemoteServer {
            remoteTaskRepositoty.update(id: task.id, new: copiedTask)
        }
    }
}
