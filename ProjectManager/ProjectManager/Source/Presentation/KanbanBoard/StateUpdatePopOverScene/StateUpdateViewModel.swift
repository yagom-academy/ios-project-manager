//
//  StateUpdateViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import Foundation

import RxSwift
import RxRelay

final class StateUpdateViewModel {
    private let updateTaskUseCase: UpdateTaskUseCase
    private var task: Task
    private let disposeBag = DisposeBag()
    
    init(updateTaskUseCase: UpdateTaskUseCase, task: Task) {
        self.updateTaskUseCase = updateTaskUseCase
        self.task = task
    }
    
    struct Input {
        let moveToTodoButtonTapEvent: Observable<Void>
        let moveToDoingButtonTapEvent: Observable<Void>
        let moveToDoneButtonTapEvent: Observable<Void>
    }
    
    struct Output {
        let isSuccess = PublishRelay<Bool>()
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        updateTaskUseCase.isUpdatedSuccess
            .subscribe(onNext: { isSuccess in
                output.isSuccess.accept(isSuccess)
            })
            .disposed(by: disposeBag)
        
        bind(with: input)
        
        return output
    }
}

private extension StateUpdateViewModel {
    func bind(with input: Input) {
        input.moveToTodoButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.updateTaskState(to: .toDo)
            })
            .disposed(by: disposeBag)
        
        input.moveToDoingButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.updateTaskState(to: .doing)
            })
            .disposed(by: disposeBag)
        
        input.moveToDoneButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.updateTaskState(to: .done)
            })
            .disposed(by: disposeBag)
    }
    
    func updateTaskState(to state: Task.State) {
        guard task.state != state else { return }
        
        task.state = state
        updateTaskUseCase.update(task)
    }
}
