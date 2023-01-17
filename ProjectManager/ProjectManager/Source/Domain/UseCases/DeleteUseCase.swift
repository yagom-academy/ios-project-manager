//
//  DeleteUseCase.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

final class DeleteUseCase {
    private weak var delegate: DidEndDeletingDelegate?
    private let repository: TaskRepository

    private let translater = Translater()
    private let disposeBag = DisposeBag()
    let isDeletedSuccess = PublishSubject<Bool>()

    init(delegate: DidEndDeletingDelegate, repository: TaskRepository) {
        self.delegate = delegate
        self.repository = repository
    }

    func deleteTask(_ task: Task) {
        guard let entity = translater.toEntity(with: task) else {
            return isDeletedSuccess.onNext(false)
        }

        repository.delete(entity)
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    self?.delegate?.didEndDeleting(task: task)
                }

                self?.isDeletedSuccess.onNext(isSuccess)
            })
            .disposed(by: disposeBag)
    }
}
