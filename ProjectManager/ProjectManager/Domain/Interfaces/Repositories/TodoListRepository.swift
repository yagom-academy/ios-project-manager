//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift
import RxRelay

protocol TodoListRepository {
    func read() -> BehaviorSubject<[TodoModel]>
    func create(to data: TodoModel)
    func update(to data: TodoModel)
    func delete(index: Int)
    var errorObserver: Observable<TodoError> { get }
}
