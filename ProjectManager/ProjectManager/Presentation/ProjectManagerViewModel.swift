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

        let todoItems = update.map { $0.filter { $0.tag == .todo } }
        let doingItems = update.map { $0.filter { $0.tag == .doing } }
        let doneItems = update.map { $0.filter { $0.tag == .done } }

        return Output(todoItems: todoItems,
                      doingItems: doingItems,
                      doneItems: doneItems)
    }
}

extension ProjectManagerViewModel {
    struct Input {
        let update: Observable<Void>
    }

    struct Output {
        let todoItems: Observable<[TaskItemViewModel]>
        let doingItems: Observable<[TaskItemViewModel]>
        let doneItems: Observable<[TaskItemViewModel]>
    }
}
