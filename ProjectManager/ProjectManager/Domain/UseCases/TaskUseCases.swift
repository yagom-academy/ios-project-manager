//
//  TaskUseCases.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import Foundation

final class TaskUseCases {
    private let localTaskRepository: TaskRepository
    private let remoteTaskRepositoty: TaskRepository
    private let userRepository: UserRepository
    
    init(
        localRepository: TaskRepository,
        remoteRepository: TaskRepository,
        userRepository: UserRepository
    ) {
        self.localTaskRepository = localRepository
        self.remoteTaskRepositoty = remoteRepository
        self.userRepository = userRepository
    }
    
    func fetchTasks() -> [Task] {
        let tasksFromLocal = localTaskRepository.fetchAll()
        
        if userRepository.isFirstLaunch {
            return remoteTaskRepositoty.fetchAll()
        } else {
            return tasksFromLocal
        }
    }
    
    func createTask(_ task: Task) {
        localTaskRepository.save(task)
        
        if userRepository.fetchUser() != nil {
            remoteTaskRepositoty.save(task)
        }
    }
    
    func updateTask(id: UUID, new task: Task) {
        localTaskRepository.update(id: id, new: task)
        
        if userRepository.fetchUser() != nil {
            remoteTaskRepositoty.update(id: id, new: task)
        }
    }
    
    func deleteTask(_ task: Task) {
        localTaskRepository.delete(task: task)
        
        if userRepository.fetchUser() != nil {
            remoteTaskRepositoty.delete(task: task)
        }
    }
    
    func moveTask(task: Task, to taskState: TaskState) {
        var copiedTask = task
        copiedTask.state = taskState
        localTaskRepository.update(id: task.id, new: copiedTask)
        
        if userRepository.fetchUser() != nil {
            remoteTaskRepositoty.update(id: task.id, new: copiedTask)
        }
    }
}
