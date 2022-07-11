//
//  TodoListUseCaseMock.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import Combine
@testable import ProjectManager

final class TodoListUseCaseMock: TodoListUseCaseable {
    let repository: TodoListRepositorible = TodoListRepositoryMock()
    
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
