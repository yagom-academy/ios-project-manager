//
//  TaskDetailViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import RxSwift

final class TaskDetailViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    struct Input {
        let editButtonTappedEvent: Observable<Void>
        let doneButtonTappedEvent: Observable<Void>
    }

    // MARK: - Output
    let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func bind(with input: Input) {
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
    }
    
}
