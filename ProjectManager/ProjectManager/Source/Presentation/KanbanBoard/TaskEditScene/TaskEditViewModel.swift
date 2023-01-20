//
//  TaskEditViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import Foundation

import RxRelay
import RxSwift

final class TaskEditViewModel {
    private let updateTaskUseCase: UpdateTaskUseCase
    
    private var task: Task
    private let disposeBag = DisposeBag()
    
    init(task: Task, updateTaskUseCase: UpdateTaskUseCase) {
        self.task = task
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    // MARK: - Output
    struct Output {
        let isSuccess = PublishRelay<Bool>()
        let isFill = PublishRelay<Bool>()
        let task: Task
    }
    
    // MARK: - Input
    struct Input {
        let titleDidEditEvent: Observable<String>
        let contentDidEditEvent: Observable<String>
        let datePickerDidEditEvent: Observable<Date>
        let doneButtonTapEvent: Observable<Void>
        let cancelButtonTapEvent: Observable<Void>
    }
    
    func transform(from input: Input) -> Output {
        let output = Output(task: self.task)
        
        updateTaskUseCase.isUpdatedSuccess
            .subscribe(onNext: { isUpdatedSuccess in
                output.isSuccess.accept(isUpdatedSuccess)
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.titleDidEditEvent, input.contentDidEditEvent)
            .subscribe(onNext: { title, content in
                output.isFill.accept(!title.isEmpty && !content.isEmpty)
            })
            .disposed(by: disposeBag)
        
        bind(with: input)
        
        return output
    }
    
    private func bind(with input: Input) {
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
                self?.task.deadLine = date.timeIntervalSince1970
            })
            .disposed(by: disposeBag)
        
        input.doneButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.updateTaskUseCase.update(self.task)
            })
            .disposed(by: disposeBag)
        
        input.cancelButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                // coordinator todo
            })
            .disposed(by: disposeBag)
    }
}
