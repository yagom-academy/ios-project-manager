//
//  CreateTaskUseCaseMock.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/19.
//

import RxSwift

final class CreateTaskUseCaseMock: CreateTaskUseCase {
    let isCreatedSuccess = PublishSubject<Bool>()

    func create(title: String, content: String, deadLine: Double) {
        isCreatedSuccess.onNext(true)
    }    
}
