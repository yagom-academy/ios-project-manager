//
//  MockHistoryStorage.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import Foundation
import Combine

@testable import ProjectManager

final class MockHistoryStorage: HistoryStorageable {
    var createCallCount = 0
    var readCallCount = 0
    var deleteCallCount = 0
    
    func create(_ item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        createCallCount += 1
        return Empty().eraseToAnyPublisher()
    }
    
    func todoHistoriesPublisher() -> CurrentValueSubject<[TodoHistory], Never> {
        readCallCount += 1
        return CurrentValueSubject<[TodoHistory], Never>([])
    }
    
    func delete(_ item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        deleteCallCount += 1
        return Empty().eraseToAnyPublisher()
    }
}
