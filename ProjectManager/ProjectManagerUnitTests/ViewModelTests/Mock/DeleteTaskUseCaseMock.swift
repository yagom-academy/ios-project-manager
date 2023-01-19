//
//  DeleteTaskUseCaseMock.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/19.
//

import RxSwift

final class DeleteTaskUseCaseMock: DeleteTaskUseCase {
    let isDeletedSuccess = PublishSubject<Bool>()

    func delete(_ task: Task) {
        isDeletedSuccess.onNext(true)
    }
}
