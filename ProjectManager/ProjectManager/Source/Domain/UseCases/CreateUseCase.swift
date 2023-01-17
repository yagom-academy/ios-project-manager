//
//  CreateUseCase.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

final class CreateUseCase {
    private weak var delegate: DidEndCreateTaskDelegate?
    private let repository: TaskRepository
    
    private let translater = Translater()
    private let disposeBag = DisposeBag()
    let isCreatedSuccess = PublishSubject<Bool>()
    
    init(delegate: DidEndCreateTaskDelegate, repository: TaskRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func addTask(_ task: Task) {
        guard let entity = translater.toEntity(with: task) else {
            return isCreatedSuccess.onNext(false)
        }
        
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
