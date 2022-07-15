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
    func checkDeadline(time: Date) -> Bool
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
    
    func checkDeadline(time: Date) -> Bool {
        return time + 24 * 60 * 60 < Date()
    }
}
