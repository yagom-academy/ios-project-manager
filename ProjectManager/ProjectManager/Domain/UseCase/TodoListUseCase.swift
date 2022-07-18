//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListUseCaseable {
    func create(_ item: Todo) -> AnyPublisher<Void, RealmError>
    func read() -> CurrentValueSubject<[Todo], Never>
    func update(_ item: Todo) -> AnyPublisher<Void, RealmError>
    func delete(item: Todo) -> AnyPublisher<Void, RealmError>
    func deleteLastItem(title: String?, content: String?) -> AnyPublisher<Void, RealmError>
}

final class TodoListUseCase: TodoListUseCaseable {
    private let repository: TodoListRepositorible
    
    init(repository: TodoListRepositorible) {
        self.repository = repository
    }
    
    func create(_ item: Todo) -> AnyPublisher<Void, RealmError> {
        return repository.create(item)
    }
    
    func read() -> CurrentValueSubject<[Todo], Never> {
        return repository.read()
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, RealmError> {
        return repository.update(item)
    }
    
    func delete(item: Todo) -> AnyPublisher<Void, RealmError> {
        return repository.delete(item: item)
    }
    
    func deleteLastItem(title: String?, content: String?) -> AnyPublisher<Void, RealmError> {
        guard title?.isEmpty == true && content?.isEmpty == true else {
            return Empty<Void, RealmError>().eraseToAnyPublisher()
        }
        
        return repository.deleteLastItem()
    }
}
