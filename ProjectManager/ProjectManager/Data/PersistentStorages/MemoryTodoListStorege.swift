//
//  MemoryTodoListStorege.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift

protocol TodoListStorege {
    func read() -> BehaviorSubject<[TodoModel]>
    func save(to data: TodoModel)
}

final class MemoryTodoListStorege {
    private var memoryStorege = BehaviorSubject<[TodoModel]>(value: TodoModel.makeDummy())
}

extension MemoryTodoListStorege: TodoListStorege {
    func read() -> BehaviorSubject<[TodoModel]> {
        return memoryStorege
    }
    
    func save(to data: TodoModel) {
        if var items = try? memoryStorege.value() {
            items.insert(data, at: 0)
            memoryStorege.onNext(items)
        }
    }
}
