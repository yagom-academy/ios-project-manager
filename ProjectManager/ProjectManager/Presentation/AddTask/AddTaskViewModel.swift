//
//  AddTaskViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation
import RxSwift

final class AddTaskViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let useCase: TaskItemsUseCase
    private var title: String
    private var description: String
    private var date: Date
    private var status: Task.Status
    
    init(useCase: TaskItemsUseCase) {
        self.title = .init()
        self.description = .init()
        self.date = Date()
        self.status = .todo
        self.useCase = useCase
    }
}

// MARK: Function

extension AddTaskViewModel {
    func transform(input: Input) -> Output {
        
        input.titleTrigger
            .subscribe(onNext: {
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
        
        let createdTask = input.doneTrigger
            .flatMap {
                let newTask = self.creatTask()
                return self.useCase
                    .create(task: newTask)
            }
        
        return Output(createdTask: createdTask)
    }
    
    private func creatTask() -> Task {
        return Task(
            title: title,
            description: description,
            expireDate: date,
            status: status,
            uuid: UUID()
        )
    }
}

// MARK: Input & Output

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
