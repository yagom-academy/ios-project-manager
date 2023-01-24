//
//  TaskSwitchViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

final class TaskSwitchViewModel: ViewModelType {
    var useCase: TaskItemsUseCase
    var task: Task

    init(useCase: TaskItemsUseCase, task: Task) {
        self.useCase = useCase
        self.task = task
    }
}

// MARK: Action
extension TaskSwitchViewModel {
    func transform(input: Input) -> Output {
        let switchDoing = input.doingTrigger
            .flatMapLatest { _ in
                let task = self.task
                let switchedTask = Task(title: task.title,
                                        description: task.description,
                                        expireDate: task.expireDate,
                                        tag: .doing,
                                        uuid: task.uuid)
                return self.useCase.update(task: switchedTask)
            }

        let switchDone = input.doneTrigger
            .flatMapLatest { _ in
                let task = self.task
                let switchedTask = Task(title: task.title,
                                        description: task.description,
                                        expireDate: task.expireDate,
                                        tag: .done,
                                        uuid: task.uuid)
                return self.useCase.update(task: switchedTask)
            }

        return Output(doingSwitched: switchDoing,
                      doneSwitched: switchDone)
    }
}

// MARK: Input & Output
extension TaskSwitchViewModel {
    struct Input {
        let doingTrigger: Observable<Void>
        let doneTrigger: Observable<Void>
    }

    struct Output {
        let doingSwitched: Observable<Task>
        let doneSwitched: Observable<Task>
    }
}
