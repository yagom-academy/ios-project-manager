//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListUseCaseable {
    func create(_ item: Todo)
    func read() -> AnyPublisher<[Todo], Never>
    func update(_ item: Todo)
    func delete(item: Todo)
    func deleteLastItem(title: String?, content: String?)
}

final class TodoListUseCase: TodoListUseCaseable {
    private let repository: TodoListRepositorible
    
    init(repository: TodoListRepositorible) {
        self.repository = repository
    }
    
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
        if title?.isEmpty == true && content?.isEmpty == true {
            repository.deleteLastItem()
        }
    }
}
