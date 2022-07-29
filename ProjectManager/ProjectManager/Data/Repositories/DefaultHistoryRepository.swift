//
//  DefaultHistoryRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation
import RxSwift
import RxRelay

final class DefaultHistoryRepository {
    private unowned let storage: HistoryStorage
    
    init(storage: HistoryStorage) {
        self.storage = storage
    }
}

extension DefaultHistoryRepository: HistoryRepository {
    func read() -> BehaviorSubject<[History]> {
        return storage.read()
    }
    
    func save(to data: History) {
        storage.save(to: data)
    }
    
    var errorObserver: Observable<TodoError> {
        return storage.errorObserver.asObservable()
    }
}
