//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol UseCase {
    func create(_ item: TodoListModel)
    func read() -> AnyPublisher<[TodoListModel], Never>
    func update(_ item: TodoListModel)
    func delete(item: TodoListModel)
    func deleteLastItem()
}

final class TodoListUseCase: UseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}

extension TodoListUseCase {
    func create(_ item: TodoListModel) {
        repository.create(item)
    }
    
    func read() -> AnyPublisher<[TodoListModel], Never> {
        return repository.read()
    }
    
    func update(_ item: TodoListModel) {
        repository.update(item)
    }
    
    func delete(item: TodoListModel) {
        repository.delete(item: item)
    }
    
    func deleteLastItem() {
        repository.deleteLastItem()
    }
}
