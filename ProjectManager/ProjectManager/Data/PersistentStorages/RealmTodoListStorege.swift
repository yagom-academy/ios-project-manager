//
//  RealmTodoListStorege.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/19.
//

import Foundation
import RxSwift
import RealmSwift

protocol TodoListStorege {
    func read() -> BehaviorSubject<[TodoModel]>
    func save(to data: TodoModel) -> Completable
    func delete(index: Int) -> Completable
}

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
    
    func save(to data: TodoModel) -> Completable {
        return Completable.create { [weak self] completable in
            do {
                try self?.realm?.write({
                    guard let items = self?.items else { return }
                    if let item = items.first(where: { $0.id == data.id }) {
                        item.updateEntity(entity: data)
                    } else {
                        self?.realm?.add(TodoEntity(entity: data))
                    }
                    self?.storege.onNext(items.map { $0.toTodoModel() })
                })
                completable(.completed)
                return Disposables.create()
            } catch {
                completable(.error(error))
                return Disposables.create()
            }
        }
    }
    
    func delete(index: Int) -> Completable {
        return Completable.create { [weak self] completable in
            do {
                try self?.realm?.write({
                    guard let items = self?.items else { return }
                    self?.realm?.delete(items[index])
                    self?.storege.onNext(items.map { $0.toTodoModel() })
                })
                completable(.completed)
                return Disposables.create()
            } catch {
                completable(.error(error))
                return Disposables.create()
            }
        }
    }
}
