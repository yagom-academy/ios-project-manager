//
//  RealmTodoListStorege.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/19.
//

import Foundation
import RxSwift
import RealmSwift

final class RealmTodoListStorege {
    private let realm = try? Realm()
    
    private var storege: BehaviorSubject<[TodoModel]>
    private let items: Results<TodoEntity>?
    
    init() {
        items = realm?.objects(TodoEntity.self)

        self.storege = .init(value: items?.map { $0.toTodoModel() } ?? [])
    }
}

extension RealmTodoListStorege: TodoListStorege {
    func read() -> BehaviorSubject<[TodoModel]> {
        return storege
    }
    
    func save(to data: TodoModel) {
        guard let items = items else { return }
        if let item = items.first(where: { $0.id == data.id }) {
            try! realm?.write({
                item.updateEntity(entity: data)
            })
            storege.onNext(items.map { $0.toTodoModel() })
        } else {
            try! realm?.write({
                realm?.add(TodoEntity(entity: data))
            })
            storege.onNext(items.map { $0.toTodoModel() })
        }
    }
    
    func delete(index: Int) {
        try! realm?.write({
            guard let items = items else { return }
            realm?.delete(items[index])
            storege.onNext(items.map { $0.toTodoModel() })
        })
    }
}
