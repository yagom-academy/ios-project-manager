//
//  DeleteUseCase.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

final class DeleteUseCase {
    private let repository: TaskRepository

    private let translater = Translater()
    private let disposeBag = DisposeBag()
    let isDeletedSuccess = PublishSubject<Bool>()

    init(repository: TaskRepository) {
        self.repository = repository
    }

    func deleteTask(_ task: Task) {
        guard let entity = translater.toEntity(with: task) else {
            return isDeletedSuccess.onNext(false)
        }

        repository.delete(entity)
            .subscribe(onNext: { [weak self] isSuccess in
                self?.isDeletedSuccess.onNext(isSuccess)
            })
            .disposed(by: disposeBag)
    }
}
