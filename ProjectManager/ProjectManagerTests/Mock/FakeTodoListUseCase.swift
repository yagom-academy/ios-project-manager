//
//  TodoListUseCaseMock.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import Combine
@testable import ProjectManager

final class FakeTodoListUseCase: TodoListUseCaseable {
    let repository: TodoListRepositorible = FakeTodoListRepository()
    
    func create(_ item: Todo) {
        repository.create(item)
    }
    
    func read() -> AnyPublisher<[Todo], Never> {
        return repository.read()
    }
    
    func update(_ item: Todo) {
        repository.update(item)
    }
    
    func delete(item: Todo) {
        repository.delete(item: item)
    }
    
    func deleteLastItem(title: String?, content: String?) {
        repository.deleteLastItem()
    }
}
