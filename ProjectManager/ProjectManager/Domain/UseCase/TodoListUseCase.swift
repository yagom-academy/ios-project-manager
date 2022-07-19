//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift

protocol TodoListUseCase {
    func readItems() -> BehaviorSubject<[TodoModel]>
    func saveItem(to data: TodoModel) -> Completable
    func deleteItem(id: UUID) -> Completable
    func checkDeadline(time: Date) -> Bool
    func moveState(from state: State) -> (first: State, second: State)
}

final class DefaultTodoListUseCase: TodoListUseCase {
    private let repository: TodoListRepository
    
    init(repository: TodoListRepository) {
        self.repository = repository
    }
}

extension DefaultTodoListUseCase {

    func readItems() -> BehaviorSubject<[TodoModel]> {
        return repository.read()
    }
    
    func saveItem(to data: TodoModel) -> Completable {
        return repository.save(to: data)
    }
    
    func deleteItem(id: UUID) -> Completable {
        guard let index = try? repository.read().value()
            .firstIndex(where: { $0.id == id }) else {
            return Completable.empty() }
        
        return repository.delete(index: index)
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
