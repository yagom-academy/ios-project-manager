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

enum TodoError: String, Error {
    case saveError = "저장 중 오류가 발생했습니다."
    case deleteError = "삭제 중 오류가 발생했습니다."
    case unknownItem = "해당 컨텐츠를 찾지 못했습니다."
    case backUpError = "데이터를 읽어오지 못했습니다."
}

protocol StorageError {
    var errorObserver: PublishRelay<TodoError> { get }
}

protocol TodoListStorage: StorageError, AnyObject {
    func read() -> BehaviorSubject<[TodoModel]>
    func save(to data: TodoModel)
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
    
    func save(to data: TodoModel) {
        do {
            try realm?.write({
                guard let items = items else { return }
                if let item = items.first(where: { $0.id == data.id }) {
                    item.updateEntity(entity: data)
                } else {
                    realm?.add(TodoRealmEntity(entity: data))
                }
                storage.onNext(items.map { $0.toTodoModel() })
            })
        } catch {
            errorObserver.accept(TodoError.saveError)
        }
    }
    
    func delete(index: Int) {
        do {
            try realm?.write({
                guard let items = items else { return }
                realm?.delete(items[index])
                storage.onNext(items.map { $0.toTodoModel() })
            })
        } catch {
            errorObserver.accept(TodoError.deleteError)
        }
    }
}
