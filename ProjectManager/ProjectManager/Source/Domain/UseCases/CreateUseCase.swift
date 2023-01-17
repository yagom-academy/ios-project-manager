//
//  CreateUseCase.swift
//  ProjectManager
//
//  Created by 이정민 on 2023/01/17.
//

import RxSwift

final class CreateUseCase {
    private let delegate: DidEndEditTaskDelegate
    private let repository: TaskRepository
    
    private let translater = Translater()
    private let disposeBag = DisposeBag()
    let createResult = PublishSubject<Bool>()
    
    init(delegate: DidEndEditTaskDelegate, repository: TaskRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func addTask(_ task: Task) {
        guard let entity = translater.toEntity(with: task) else {
            return self.createResult.onNext(false)
        }
        
        repository.create(entity)
            .subscribe(onNext: { result in
                if result == true {
                    self.delegate.didEndEdit(task: task)
                }
                
                self.createResult.onNext(result)
            })
            .disposed(by: disposeBag)
    }
}
