//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift
import RxRelay

protocol TodoListUseCase {
    func readItems() -> BehaviorSubject<[TodoModel]>
    func saveItem(to data: TodoModel)
    func deleteItem(id: UUID)
    func checkDeadline(time: Date) -> Bool
    func moveState(from state: State) -> (first: State, second: State)
    var errorObserver: PublishRelay<TodoError> { get }
}

final class DefaultTodoListUseCase {
    private let repository: TodoListRepository
    
    init(repository: TodoListRepository) {
        self.repository = repository
    }
}

extension DefaultTodoListUseCase: TodoListUseCase {
    var errorObserver: PublishRelay<TodoError> {
        repository.errorObserver
    }

    func readItems() -> BehaviorSubject<[TodoModel]> {
        return repository.read()
    }
    
    func saveItem(to data: TodoModel) {
        repository.save(to: data)
    }
    
    func deleteItem(id: UUID) {
        guard let index = try? repository.read().value()
            .firstIndex(where: { $0.id == id }) else {
            errorObserver.accept(TodoError.unknownItem)
            return
        }
        
        repository.delete(index: index)
    }
    
    func checkDeadline(time: Date) -> Bool {
        return time + 24 * 60 * 60 < Date()
    }

    func moveState(from state: State) -> (first: State, second: State) {
        switch state {
        case .todo:
            return (.doing, .done)
        case .doing:
            return (.todo, .done)
        case .done:
            return (.todo, .doing)
        }
    }
}
