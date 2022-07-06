//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol UseCase {
    func read() -> AnyPublisher<[TodoListModel], Never>
}

final class TodoListUseCase: UseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}

extension TodoListUseCase {
    func read() -> AnyPublisher<[TodoListModel], Never> {
        repository.read()
    }
}
