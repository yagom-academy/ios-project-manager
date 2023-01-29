//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

final class TaskListViewModel: ViewModelType {
    private let useCase: TaskUseCaseType
    
    init(useCase: TaskUseCaseType) {
        self.useCase = useCase
    }
}

extension TaskListViewModel {
    
    func transform(input: Input) -> Output {
        
        let update = input.update
            .flatMap {
                return self.useCase
                    .getTasks()
                    .map { $0.map { TaskItemViewModel(task: $0) } }
            }
        
        let delete = input.delete
            .flatMap { item in
                return self.useCase
                    .delete(task: item.task)
            }
        
        let todoItems = update.map { $0.filter { $0.status == .todo } }
        let doingItems = update.map { $0.filter { $0.status == .doing } }
        let doneItems = update.map { $0.filter { $0.status == .done } }
        
        return Output(
            todoItems: todoItems,
            doingItems: doingItems,
            doneItems: doneItems,
            deletedItem: delete
        )
    }
}

extension TaskListViewModel {
    struct Input {
        let update: Observable<Void>
        let delete: Observable<TaskItemViewModel>
    }
    struct Output {
        let todoItems: Observable<[TaskItemViewModel]>
        let doingItems: Observable<[TaskItemViewModel]>
        let doneItems: Observable<[TaskItemViewModel]>
        let deletedItem: Observable<Task>
    }
}
