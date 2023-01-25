//
//  TaskItemsUseCase.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import RxSwift

final class TaskItemsUseCase {
    private let datasource: DataSourceType

    init(datasource: DataSourceType) {
        self.datasource = datasource
    }
}

extension TaskItemsUseCase: TaskUseCaseType {
    func getTasks() -> Observable<[Task]> {
        return datasource.fetch()
    }

    func create(task: Task) -> Observable<Task> {
        return datasource.create(task: task)
    }

    func update(task: Task) -> Observable<Task> {
        return datasource.update(task: task)
    }

    func delete(task: Task) -> RxSwift.Observable<Task> {
        return datasource.delete(task: task)
    }
}
