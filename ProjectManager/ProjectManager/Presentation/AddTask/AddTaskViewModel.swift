//
//  AddTaskViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

final class AddTaskViewModel: ViewModelType {
    var title: String
    var description: String
    var date: Date
    var tag: Status
    var useCase: TaskItemsUseCase

    init(useCase: TaskItemsUseCase) {
        self.title = ""
        self.description = ""
        self.date = Date()
        self.tag = .todo
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {

        let title = input.titleTrigger
            .subscribe(onNext: {
                self.title = $0
            })
        let description = input.descriptionTrigger
            .subscribe(onNext: {
                self.description = $0
            })
        let date = input.dateTrigger
            .subscribe(onNext: {
            self.date = $0
            })

        let createdTask = input.doneTrigger.flatMapLatest {
            let newTask = Task(title: self.title,
                               description: self.description,
                               expireDate: self.date,
                               tag: self.tag,
                               uuid: UUID())
            return self.useCase.create(task: newTask)
        }

        return Output(createdTask: createdTask)
    }
}

extension AddTaskViewModel {
    struct Input {
        let doneTrigger: Observable<Void>
        let titleTrigger: Observable<String>
        let descriptionTrigger: Observable<String>
        let dateTrigger: Observable<Date>
    }

    struct Output {
        let createdTask: Observable<Task>
    }
}
