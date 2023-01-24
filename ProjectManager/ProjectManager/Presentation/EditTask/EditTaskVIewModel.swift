//
//  EditTaskVIewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

final class EditTaskViewModel: ViewModelType {
    var title: String
    var description: String
    var date: Date
    var tag: Status
    var task: Task
    var useCase: TaskItemsUseCase
    
    init(item: TaskItemViewModel, useCase: TaskItemsUseCase) {
        self.title = item.title
        self.description = item.description
        self.date = item.date
        self.tag = item.tag
        self.task = item.task
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        
        let canEdit = input.editTrigger.flatMapLatest {
            return Observable.just(true)
        }
        
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

        
        let editedTask = input.doneTrigger
            .flatMapLatest {
                let editedTask = Task(title: self.title,
                                      description: self.description,
                                      expireDate: self.date,
                                      tag: self.tag,
                                      uuid: self.task.uuid)
            return self.useCase.update(task: editedTask)
        }
        
        return Output(canEdit: canEdit, editedTask: editedTask)
    }
}

extension EditTaskViewModel {
    struct Input {
        let editTrigger: Observable<Void>
        let doneTrigger: Observable<Void>
        let titleTrigger: Observable<String>
        let descriptionTrigger: Observable<String>
        let dateTrigger: Observable<Date>
    }
    
    struct Output {
        let canEdit: Observable<Bool>
        let editedTask: Observable<Task>
    }
}
