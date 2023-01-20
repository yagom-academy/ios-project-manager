//
//  DefaultUpdateTaskUseCase.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

protocol UpdateTaskUseCase {
    var isUpdatedSuccess: PublishSubject<Bool> { get }
    func update(_ task: Task)
}

final class DefaultUpdateTaskUseCase: UpdateTaskUseCase {
    private weak var delegate: DidEndUpdatingDelegate?
    private let repository: TaskRepository

    private let translater = Translater()
    private let disposeBag = DisposeBag()
    let isUpdatedSuccess = PublishSubject<Bool>()

    init(delegate: DidEndUpdatingDelegate? = nil, repository: TaskRepository) {
        self.delegate = delegate
        self.repository = repository
    }

    func update(_ task: Task) {
        let entity = translater.toEntity(with: task)

        repository.update(entity)
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    self?.delegate?.didEndUpdating(task: task)
                }

                self?.isUpdatedSuccess.onNext(isSuccess)
            })
            .disposed(by: disposeBag)
    }
}
