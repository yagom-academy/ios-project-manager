//
//  ViewModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import RxRelay
import RxSwift

import Foundation

final class TaskCreateViewModel {
    let createTaskUseCase: CreateTaskUseCase
    
    private var title: String = ""
    private var content: String = ""
    private var date: Double = 0
    
    init(createTaskUseCase: CreateTaskUseCase) {
        self.createTaskUseCase = createTaskUseCase
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
        
        createTaskUseCase.isCreatedSuccess
            .subscribe(onNext: { isCreateSuccess in
                output.isSuccess.accept(isCreateSuccess)
            })
            .disposed(by: disposeBag)
        
        bind(with: input, disposeBag: disposeBag)
        
        return output
    }
    
    private func bind(with input: Input, disposeBag: DisposeBag) {
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
                self?.date = date
            })
            .disposed(by: disposeBag)
        
        input.doneButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                let task = Task( // 이후 생 데이터를 넘겨주는 방식으로 변경
                    id: UUID().uuidString,
                    title: self.title,
                    content: self.content,
                    deadLine: self.date,
                    state: .toDo,
                    isExpired: false
                )
                
                self.createTaskUseCase.addTask(task)
            })
            .disposed(by: disposeBag)
    }
}
