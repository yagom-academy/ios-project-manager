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
}

protocol TodoListStorege {
    func read() -> BehaviorSubject<[TodoModel]>
    func save(to data: TodoModel)
    func delete(index: Int)
    var errorObserver: PublishRelay<TodoError> { get }
}

final class RealmTodoListStorege {
    private let realm = try? Realm()
    
    private var storege: BehaviorSubject<[TodoModel]>
    private let items: Results<TodoEntity>?
    let errorObserver: PublishRelay<TodoError> = PublishRelay()

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
        do {
            try realm?.write({
                guard let items = items else { return }
                if let item = items.first(where: { $0.id == data.id }) {
                    item.updateEntity(entity: data)
                } else {
                    realm?.add(TodoEntity(entity: data))
                }
                storege.onNext(items.map { $0.toTodoModel() })
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
                storege.onNext(items.map { $0.toTodoModel() })
            })
        } catch {
            errorObserver.accept(TodoError.deleteError)
        }
    }
}
