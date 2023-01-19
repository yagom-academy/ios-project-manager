//
//  UpdateTaskUseCaseMock.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/19.
//

import RxSwift

final class UpdateTaskUseCaseMock: UpdateTaskUseCase {
    let isUpdatedSuccess = PublishSubject<Bool>()

    func update(_ task: Task) {
        isUpdatedSuccess.onNext(true)
    }
}
