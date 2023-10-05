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
    
    /// 로그인을 언제하던 상관없이 로컬 데이터는 리모트 데이터로 덮어쓰고
    /// 로그인한 계정에 저장되어있는 데이터를 가져온다.
    func registerFetch() async -> [Task] {
        let remoteTasks = await fetchRemoteTasks()
        localTaskRepository.deleteAll()
        remoteTasks.forEach { localTaskRepository.save($0) }
        return remoteTasks
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
}
