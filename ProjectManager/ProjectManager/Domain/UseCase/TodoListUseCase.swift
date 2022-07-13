//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift

protocol UseCase {
    func readRepository() -> BehaviorSubject<[TodoModel]>
    func saveRepository(to data: TodoModel)
    func checkDeadline(time: Date) -> Bool
}

final class TodoListUseCase: UseCase {
    private let repository: TodoListRepository
    
    init(repository: TodoListRepository) {
        self.repository = repository
    }
}

extension TodoListUseCase {

    func readRepository() -> BehaviorSubject<[TodoModel]> {
        return repository.read()
    }
    
    func saveRepository(to data: TodoModel) {
        repository.save(to: data)
    }
    
    func checkDeadline(time: Date) -> Bool {
        return time + 24 * 60 * 60 < Date()
    }
}
