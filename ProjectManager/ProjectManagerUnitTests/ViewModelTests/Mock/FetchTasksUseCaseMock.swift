//
//  FetchTasksUseCaseMock.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/19.
//

import RxSwift

final class FetchTasksUseCaseMock: FetchTasksUseCase {
    let tasks = BehaviorSubject<[Task]>(value: [])

    func fetchAllTasks() {
        tasks.onNext(TaskDummy.dummys)
    }
    
    func didEndCreating(task: Task) {
        return
    }
    
    func didEndUpdating(task: Task) {
        return
    }
    
    func didEndDeleting(task: Task) {
        return
    }
}
