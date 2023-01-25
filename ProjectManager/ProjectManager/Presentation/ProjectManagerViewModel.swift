//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

final class ProjectManagerViewModel: ViewModelType {
    private var useCase: TaskUseCaseType

    init(useCase: TaskUseCaseType) {
        self.useCase = useCase
    }
}

extension ProjectManagerViewModel {

    func transform(input: Input) -> Output {

        let update = input.update.flatMapLatest {
            return self.useCase.getTasks()
                .map { $0.map { TaskItemViewModel(task: $0) } }
        }
        
        let delete = input.delete.flatMapLatest { item in
            return self.useCase.delete(task: item.task)
        }

        let todoItems = update.map { $0.filter { $0.status == .todo } }
        let doingItems = update.map { $0.filter { $0.status == .doing } }
        let doneItems = update.map { $0.filter { $0.status == .done } }

        return Output(todoItems: todoItems,
                      doingItems: doingItems,
                      doneItems: doneItems,
                      deletedItem: delete)
    }
}

extension ProjectManagerViewModel {
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
