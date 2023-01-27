//
//  EditTaskViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

final class EditTaskViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private var useCase: TaskItemsUseCase
    private var title: String
    private var description: String
    private var date: Date
    private var status: Task.Status
    private var task: Task
    
    init(item: TaskItemViewModel, useCase: TaskItemsUseCase) {
        self.title = item.title
        self.description = item.description
        self.date = item.date
        self.status = item.status
        self.task = item.task
        self.useCase = useCase
    }
}

// MARK: Function

extension EditTaskViewModel {
    
    func transform(input: Input) -> Output {
        
        let canEdit = input.editTrigger
            .flatMapLatest {
                return Observable.just(true)
            }
        
        let initialSetUpItem = input.initialSetUpTrigger
            .map { _ in
                return InitialEditItem(
                    title: self.title,
                    date: self.date,
                    description: self.description
                )
            }
        
        input.titleTrigger
            .subscribe(
                onNext: {
                    self.title = $0
                }
            )
            .disposed(by: disposeBag)
        
        input.descriptionTrigger
            .subscribe(
                onNext: {
                    self.description = $0
                }
            )
            .disposed(by: disposeBag)
        
        input.dateTrigger
            .subscribe(
                onNext: {
                    self.date = $0
                }
            )
            .disposed(by: disposeBag)
        
        
        let editedTask = input.doneTrigger
            .flatMapLatest {
                let editedTask = self.reformTask()
                
                return self.useCase
                    .update(task: editedTask)
            }
        
        return Output(
            canEdit: canEdit,
            editedTask: editedTask,
            initialSetUpData: initialSetUpItem
        )
    }
    
    private func reformTask() -> Task {
        return Task(
            title: title,
            description: description,
            expireDate: date,
            status: status,
            uuid: task.uuid
        )
    }
}

// MARK: Input & Output

extension EditTaskViewModel {
    struct Input {
        let initialSetUpTrigger: Observable<Void>
        let editTrigger: Observable<Void>
        let doneTrigger: Observable<Void>
        let titleTrigger: Observable<String>
        let descriptionTrigger: Observable<String>
        let dateTrigger: Observable<Date>
    }
    struct Output {
        let canEdit: Observable<Bool>
        let editedTask: Observable<Task>
        let initialSetUpData: Observable<InitialEditItem>
    }
    struct InitialEditItem {
        let title: String
        let date: Date
        let description: String
    }
}
