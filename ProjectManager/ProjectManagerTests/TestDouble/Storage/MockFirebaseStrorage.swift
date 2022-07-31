//
//  MockFirebaseStrorage.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import Foundation
import Combine

@testable import ProjectManager

final class MockFirebaseStrorage: RemoteStorageable {
    var backupCallCount = 0
    var readCallCount = 0
    
    func backup(_ items: [Todo]) {
        backupCallCount += 1
    }
    
    func todosPublisher() -> CurrentValueSubject<[Todo], StorageError> {
        readCallCount += 1
        return CurrentValueSubject<[Todo], StorageError>([])
    }
}
