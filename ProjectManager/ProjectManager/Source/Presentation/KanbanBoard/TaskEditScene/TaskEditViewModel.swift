//
//  ViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import RxRelay
import RxSwift

import Foundation

final class TaskEditViewModel {
    let updateTaskUseCase: UpdateTaskUseCase
    
    private var task: Task
    
    init(task: Task, updateTaskUseCase: UpdateTaskUseCase) {
        self.task = task
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    // MARK: - Output
    struct Output {
        let isSuccess = PublishRelay<Bool>()
    }
    
    // MARK: - Input
    struct Input {
        let titleDidEditEvent: Observable<String>
        let contentDidEditEvent: Observable<String>
        let datePickerDidEditEvent: Observable<Double>
        let doneButtonTapEvent: Observable<Void>
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        updateTaskUseCase.isUpdatedSuccess
            .subscribe(onNext: { isUpdatedSuccess in
                output.isSuccess.accept(isUpdatedSuccess)
            })
            .disposed(by: disposeBag)
        
        bind(with: input, disposeBag: disposeBag)
        
        return output
    }
    
    private func bind(with input: Input, disposeBag: DisposeBag) {
        input.titleDidEditEvent
            .subscribe(onNext: { [weak self] title in
                self?.task.title = title
            })
            .disposed(by: disposeBag)
        
        input.contentDidEditEvent
            .subscribe(onNext: { [weak self] content in
                self?.task.content = content
            })
            .disposed(by: disposeBag)
        
        input.datePickerDidEditEvent
            .subscribe(onNext: { [weak self] date in
                self?.task.deadLine = date
            })
            .disposed(by: disposeBag)
        
        input.doneButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.updateTaskUseCase.update(self.task)
            })
            .disposed(by: disposeBag)
    }
}
