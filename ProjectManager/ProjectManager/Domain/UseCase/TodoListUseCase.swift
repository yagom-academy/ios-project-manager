//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListUseCaseable {
    func create(_ item: TodoListModel)
    func read() -> AnyPublisher<[TodoListModel], Never>
    func update(_ item: TodoListModel)
    func delete(item: TodoListModel)
    func deleteLastItem(title: String?, content: String?)
}

final class TodoListUseCase: TodoListUseCaseable {
    private let repository: TodoListRepositorible
    
    init(repository: TodoListRepositorible) {
        self.repository = repository
    }
    
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
    
    func deleteLastItem(title: String?, content: String?) {
        if title?.isEmpty == true && content?.isEmpty == true {
            repository.deleteLastItem()
        }
    }
}
