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
    #if DEBUG
    private var memoryStorege = BehaviorSubject<[TodoModel]>(value: TodoModel.makeDummy())
    #else
    private var memoryStorege = BehaviorSubject<[TodoModel]>(value: [])
    #endif
}

extension MemoryTodoListStorege: TodoListStorege {
    func read() -> BehaviorSubject<[TodoModel]> {
        return memoryStorege
    }
    
    func save(to data: TodoModel) {
        guard var items = try? memoryStorege.value() else { return }
        if let index = items.firstIndex(where: { $0.id == data.id }) {
            items[index] = data
            memoryStorege.onNext(items)
        } else {
            items.insert(data, at: 0)
            memoryStorege.onNext(items)
        }
    }
}
