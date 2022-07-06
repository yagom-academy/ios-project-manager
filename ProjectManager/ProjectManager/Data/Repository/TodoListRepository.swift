//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

final class TodoListRepository {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
}

extension TodoListRepository: Repository {
    func read() -> AnyPublisher<[TodoListModel], Never> {
        return storage.read()
    }
}
