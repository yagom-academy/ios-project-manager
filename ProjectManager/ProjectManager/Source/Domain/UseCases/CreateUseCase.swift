//
//  CreateUseCase.swift
//  ProjectManager
//
//  Created by 이정민 on 2023/01/17.
//

import RxSwift

final class CreateUseCase {
    private weak var delegate: DidEndEditTaskDelegate?
    private let repository: TaskRepository
    
    private let translater = Translater()
    private let disposeBag = DisposeBag()
    let isCreatedSuccess = PublishSubject<Bool>()
    
    init(delegate: DidEndEditTaskDelegate, repository: TaskRepository) {
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
                    self?.delegate?.didEndEdit(task: task)
                }
                
                self?.isCreatedSuccess.onNext(isSuccess)
            })
            .disposed(by: disposeBag)
    }
}
