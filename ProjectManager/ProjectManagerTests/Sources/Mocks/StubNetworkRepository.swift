//
//  StubNetworkRepository.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/05.
//

import Foundation
@testable import ProjectManager

final class StubNetworkRepository: TaskNetworkRepositoryProtocol {

    var isFetchTaskCalled: Bool = false
    var isPostCalled: Bool = false
    var isPatchCalled: Bool = false
    var isDeleteCalled: Bool = false

    var expectedResponseTasks: [ResponseTask]!
    var expectedResponseTask: ResponseTask!
    var expectedResponseStatusCode: HTTPStatusCode!
    var expectedPMError: PMError!

    func fetchTasks(completion: @escaping (Result<[ResponseTask], PMError>) -> Void) {
        isFetchTaskCalled = true
        expectedPMError == nil
            ? completion(.success(expectedResponseTasks))
            : completion(.failure(expectedPMError))
    }
    
    func post(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void) {
        isPostCalled = true
        expectedPMError == nil
            ? completion(.success(expectedResponseTask))
            : completion(.failure(expectedPMError))
    }
    
    func patch(task: Task, completion: @escaping (Result<ResponseTask, PMError>) -> Void) {
        isPatchCalled = true
        expectedPMError == nil
            ? completion(.success(expectedResponseTask))
            : completion(.failure(expectedPMError))
    }
    
    func delete(task: Task, completion: @escaping (Result<HTTPStatusCode, PMError>) -> Void) {
        isDeleteCalled = true
        expectedPMError == nil
            ? completion(.success(expectedResponseStatusCode))
            : completion(.failure(expectedPMError))
    }
}
