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
    func saveItem(to data: TodoModel)
    func deleteItem(id: UUID)
    func checkDeadline(time: Date) -> Bool
    func changeToTitle(at state: State) -> (String, String)
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
    
    func saveItem(to data: TodoModel) {
        repository.save(to: data)
    }
    
    func deleteItem(id: UUID) {
        guard let index = try? repository.read().value()
            .firstIndex(where: { $0.id == id }) else { return }
        
        repository.delete(index: index)
    }
    
    func checkDeadline(time: Date) -> Bool {
        return time + 24 * 60 * 60 < Date()
    }
    
    func changeToTitle(at state: State) -> (String, String) {
        switch state {
        case .todo:
            return ("Move to DOING", "Move to DONE")
        case .doing:
            return ("Move to TODO", "Move to DONE")
        case .done:
            return ("Move to TODO", "Move to DOING")
        }
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
