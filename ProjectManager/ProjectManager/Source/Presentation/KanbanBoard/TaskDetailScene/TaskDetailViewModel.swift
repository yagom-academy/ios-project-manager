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
    private let didTappedEditButtonHandler: (Bool) -> Void
    
    // MARK: - Input
    struct Input {
        let editButtonTappedEvent: Observable<Void>
    }

    // MARK: - Output
    struct Output {
        let task: Task
    }
    
    init(task: Task, didTappedEditButtonHandler: @escaping (Bool) -> Void) {
        self.task = task
        self.didTappedEditButtonHandler = didTappedEditButtonHandler
    }
    
    func transform(from input: Input) -> Output {
        input.editButtonTappedEvent
            .subscribe(onNext: { [weak self] _ in
                self?.didTappedEditButtonHandler(true)
            })
            .disposed(by: disposeBag)
        
        return Output(task: self.task)
    }
    
}
