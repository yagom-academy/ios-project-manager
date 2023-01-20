//
//  DefaultCreateTaskUseCase.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

protocol CreateTaskUseCase {
    var isCreatedSuccess: PublishSubject<Bool> { get }
    
    func create(title: String,
                content: String,
                deadLine: Double)
}

final class DefaultCreateTaskUseCase: CreateTaskUseCase {
    private weak var delegate: DidEndCreatingTaskDelegate?
    private let repository: TaskRepository
    
    private let translater = Translater()
    private let disposeBag = DisposeBag()
    let isCreatedSuccess = PublishSubject<Bool>()
    
    init(delegate: DidEndCreatingTaskDelegate? = nil, repository: TaskRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func create(title: String,
                content: String,
                deadLine: Double
    ) {
        let task = Task(
            title: title,
            content: content,
            deadLine: deadLine
        )
        
        let entity = translater.toEntity(with: task)
        
        repository.create(entity)
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    self?.delegate?.didEndCreating(task: task)
                }
                
                self?.isCreatedSuccess.onNext(isSuccess)
            })
            .disposed(by: disposeBag)
    }
}
