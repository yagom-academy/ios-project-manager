//
//  MockHistoryRepository.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/29.
//

import Foundation
import RxSwift
@testable import ProjectManager

class MockHistoryRepository: HistoryRepository {
    var errorObserver: Observable<TodoError> = .just(.saveError)
    
    private let storage = BehaviorSubject<[History]>(value: [])
    
    func read() -> BehaviorSubject<[History]> {
        return storage
    }
    
    func save(to data: History) {
        let items = try! storage.value()
        storage.onNext(items +  [data])
    }
}
