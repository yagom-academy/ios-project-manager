//
//  EditTaskViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

final class UpdateTaskViewModel: ViewModelType {
    
    // MARK: Property
    
    private let disposeBag = DisposeBag()
    private let useCase: TaskItemsUseCase
    let operationType: TaskOperationType
    
    private var task: Task?
    private var status: Task.Status
    private var title: String
    private var description: String
    private var date: Date
    
    init(useCase: TaskItemsUseCase,
         operationType: TaskOperationType,
         item: TaskItemViewModel? = nil) {
        self.useCase = useCase
        self.title = item?.title ?? .init()
        self.description = item?.description ?? .init()
        self.date = item?.date ?? .init()
        self.status = item?.status ?? .todo
        self.task = item?.task
        self.operationType = operationType
    }
    
    // MARK: Function(s)
    
    func transform(input: Input) -> Output {
        
        let initialSetUpItem = input.initialSetUpTrigger
            .map { _ in
                return InitialEditItem(
                    title: self.title,
                    date: self.date,
                    description: self.description
                )
            }
        
        input.titleTrigger
            .subscribe(onNext: {
                self.title = $0
            })
            .disposed(by: disposeBag)
        
        input.descriptionTrigger
            .subscribe(onNext: {
                self.description = $0
            })
            .disposed(by: disposeBag)
        
        input.dateTrigger
            .subscribe(onNext: {
                self.date = $0
            })
            .disposed(by: disposeBag)
        
        
        let formedTask = input.doneTrigger
            .flatMap {
                let task = self.formTask()
                
                switch self.operationType {
                case .add:
                    return self.useCase
                        .create(task: task)
                case .edit:
                    return self.useCase
                        .update(task: task)
                }
            }
        
        return Output(
            initialSetUpData: initialSetUpItem,
            formedTask: formedTask
        )
    }
    
    // MARK: Private Function(s)
    
    private func formTask() -> Task {
        return Task(
            title: title,
            description: description,
            expireDate: date,
            status: status,
            uuid: task?.uuid ?? UUID()
        )
    }
}

// MARK: Input & Output

extension UpdateTaskViewModel {
    struct Input {
        let initialSetUpTrigger: Observable<Void>
        let doneTrigger: Observable<Void>
        let titleTrigger: Observable<String>
        let descriptionTrigger: Observable<String>
        let dateTrigger: Observable<Date>
    }
    struct Output {
        let initialSetUpData: Observable<InitialEditItem>
        let formedTask: Observable<Task>
    }
    struct InitialEditItem {
        let title: String
        let date: Date
        let description: String
    }
}
