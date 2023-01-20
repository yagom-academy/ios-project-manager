//
//  TaskCreateViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import Foundation

import RxRelay
import RxSwift

final class TaskCreateViewModel {
    private let createTaskUseCase: CreateTaskUseCase
    
    private var title: String = ""
    private var content: String = ""
    private var date: Double = 0
    
    private let disposeBag = DisposeBag()
    
    init(createTaskUseCase: CreateTaskUseCase) {
        self.createTaskUseCase = createTaskUseCase
    }
    
    // MARK: - Output
    struct Output {
        let isSuccess = PublishRelay<Bool>()
        let isFill = PublishRelay<Bool>()
    }
    
    // MARK: - Input
    struct Input {
        let titleDidEditEvent: Observable<String>
        let contentDidEditEvent: Observable<String>
        let datePickerDidEditEvent: Observable<Date>
        let doneButtonTapEvent: Observable<Void>
    }
    
    func transform(from input: Input) -> Output {
        let output = Output()
        
        createTaskUseCase.isCreatedSuccess
            .subscribe(onNext: { isCreateSuccess in
                output.isSuccess.accept(isCreateSuccess)
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
                self?.title = title
            })
            .disposed(by: disposeBag)
        
        input.contentDidEditEvent
            .subscribe(onNext: { [weak self] content in
                self?.content = content
            })
            .disposed(by: disposeBag)
        
        input.datePickerDidEditEvent
            .subscribe(onNext: { [weak self] date in
                self?.date = date.timeIntervalSince1970
            })
            .disposed(by: disposeBag)
        
        input.doneButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.createTaskUseCase.create(
                    title: self.title,
                    content: self.content,
                    deadLine: self.date
                )
            })
            .disposed(by: disposeBag)
    }
}
