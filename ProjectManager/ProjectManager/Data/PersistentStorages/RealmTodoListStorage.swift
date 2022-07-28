//
//  RealmTodoListStorege.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/19.
//

import Foundation
import RxSwift
import RealmSwift
import RxRelay

protocol TodoListStorage: ErrorThrowble, AnyObject {
    func read() -> BehaviorSubject<[TodoModel]>
    func create(to data: TodoModel)
    func update(to data: TodoModel)
    func delete(index: Int)
}

final class RealmTodoListStorage {
    private let realm = try? Realm()
    
    private var storage: BehaviorSubject<[TodoModel]>
    private let items: Results<TodoRealmEntity>?
    let errorObserver: PublishRelay<TodoError> = PublishRelay()

    init() {
        items = realm?.objects(TodoRealmEntity.self)

        self.storage = .init(value: items?.map { $0.toTodoModel() } ?? [])
    }
}

extension RealmTodoListStorage: TodoListStorage {
    func read() -> BehaviorSubject<[TodoModel]> {
        return storage
    }
    
    func create(to data: TodoModel) {
        do {
            try realm?.write({
                guard let items = items else { return }
                realm?.add(TodoRealmEntity(entity: data))
                storage.onNext(items.map { $0.toTodoModel() })
            })
        } catch {
            errorObserver.accept(TodoError.saveError)
        }
    }
    
    func update(to data: TodoModel) {
        do {
            try realm?.write({
                guard let items = items else {
                    errorObserver.accept(TodoError.unknownItem)
                    storage.onNext([])
                    return
                }
                guard let item = items.first(where: { $0.id == data.id }) else {
                    errorObserver.accept(TodoError.unknownItem)
                    storage.onNext(items.map { $0.toTodoModel() })
                    return
                }
                item.updateEntity(entity: data)
                storage.onNext(items.map { $0.toTodoModel() })
            })
        } catch {
            errorObserver.accept(TodoError.saveError)
        }
    }
    
    func delete(index: Int) {
        do {
            try realm?.write({
                guard let items = items else {
                    errorObserver.accept(TodoError.unknownItem)
                    storage.onNext([])
                    return
                }
                guard let item = items[safe: index] else {
                    errorObserver.accept(TodoError.unknownItem)
                    storage.onNext(items.map { $0.toTodoModel() })
                    return
                }
                realm?.delete(item)
                storage.onNext(items.map { $0.toTodoModel() })
            })
        } catch {
            errorObserver.accept(TodoError.deleteError)
        }
    }
}
