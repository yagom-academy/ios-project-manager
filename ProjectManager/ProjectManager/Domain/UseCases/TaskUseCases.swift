//
//  TaskUseCases.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import Foundation

@MainActor
final class TaskUseCases {
    private let localTaskRepository: TaskLocalRepository
    private let remoteTaskRepositoty: TaskRemoteRepository
    private let userRepository: UserRepository
    
    init(
        localRepository: TaskLocalRepository,
        remoteRepository: TaskRemoteRepository,
        userRepository: UserRepository
    ) {
        self.localTaskRepository = localRepository
        self.remoteTaskRepositoty = remoteRepository
        self.userRepository = userRepository
    }
    
    var user: User? {
        userRepository.fetchUser()
    }
    
    func initialFetch() async -> [Task] {
        if userRepository.isFirstLaunch {
            return await fetchRemoteTasks()
        } else {
            return fetchLocalTasks()
        }
    }
    
    /// 로그인 할 때 로컬 데이터가 없으면 서버에서 가져옴
    /// 데이터가 있다면 로컬 데이터를 서버에 덮어쓰고 로컬에서 가져옴
    func registerFetch() async -> [Task] {
        let localTasks = fetchLocalTasks()
        
        if localTasks.isEmpty {
            return await fetchRemoteTasks()
        } else {
            syncronize()
            return localTasks
        }
    }
    
    func fetchLocalTasks() -> [Task] {
        localTaskRepository.fetchAll()
    }
    
    func fetchRemoteTasks() async -> [Task] {
        if let user = user {
            return await remoteTaskRepositoty.fetchAll(by: user)
        } else {
            return []
        }
    }
    
    func createTask(_ task: Task) {
        localTaskRepository.save(task)
        
        if let user = user {
            remoteTaskRepositoty.save(task, by: user)
        }
    }
    
    func updateTask(id: UUID, new task: Task) {
        localTaskRepository.update(id: id, new: task)
        
        if let user = user {
            remoteTaskRepositoty.update(id: id, new: task, by: user)
        }
    }
    
    func deleteTask(_ task: Task) {
        localTaskRepository.delete(task)
        
        if let user = user {
            remoteTaskRepositoty.delete(task, by: user)
        }
    }
    
    func moveTask(task: Task, to taskState: TaskState) {
        var copiedTask = task
        copiedTask.state = taskState
        localTaskRepository.update(id: task.id, new: copiedTask)
        
        if let user = user {
            remoteTaskRepositoty.update(id: task.id, new: copiedTask, by: user)
        }
    }
    
    func syncronize() {
        if let user = user {
            let localTasks = localTaskRepository.fetchAll()
            remoteTaskRepositoty.syncronize(from: localTasks, by: user)
        }
    }
}
