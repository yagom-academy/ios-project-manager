//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation

protocol UseCase {
    func readRepository() -> [TodoModel]
    func saveRepository(to data: TodoModel)
}

final class TodoListUseCase {
    private let repository: TodoListRepository
    
    init(repository: TodoListRepository) {
        self.repository = repository
    }
}

extension TodoListUseCase: UseCase {
    func readRepository() -> [TodoModel] {
        return repository.read()
    }
    
    func saveRepository(to data: TodoModel) {
        repository.save(to: data)
    }
}
