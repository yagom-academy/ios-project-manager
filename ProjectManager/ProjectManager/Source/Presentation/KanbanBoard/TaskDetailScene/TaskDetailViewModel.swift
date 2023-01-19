//
//  TaskDetailViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import RxSwift

final class TaskDetailViewModel {
    private let disposeBag = DisposeBag()
    private let task: Task
    
    // MARK: - Input
    struct Input {
        let editButtonTappedEvent: Observable<Void>
        let doneButtonTappedEvent: Observable<Void>
    }

    // MARK: - Output
    struct Output {
        let task: Task
    }
    
    init(task: Task) {
        self.task = task
    }
    
    func transform(with input: Input) -> Output {
        input.editButtonTappedEvent
            .subscribe(onNext: {
                // coordinator todo
            })
            .disposed(by: disposeBag)
        
        input.doneButtonTappedEvent
            .subscribe(onNext: {
                // coordinator todo
            })
            .disposed(by: disposeBag)
        
        return Output(task: self.task)
    }
    
}
