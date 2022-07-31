//
//  RealmStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Combine

import RealmSwift

enum LocalStorageState {
    case success(items: [Todo])
    case failure(error: StorageError)
}

enum StorageError: LocalizedError {
    case createFail
    case updateFail
    case deleteFail
    case readFail
    
    var errorDescription: String? {
        switch self {
        case .createFail:
            return "데이터를 생성하지 못했습니다."
        case .updateFail:
            return "데이터를 업데이트하지 못했습니다."
        case .deleteFail:
            return "데이터를 삭제하지 못했습니다."
        case .readFail:
            return "데이터를 불러오지 못했습니다."
        }
    }
}

protocol LocalStorageable: AnyObject {
    func create(_ item: Todo)
    var todosPublisher: CurrentValueSubject<LocalStorageState, Never> { get }
    func update(_ item: Todo)
    func delete(_ item: Todo)
}

final class RealmStorage: LocalStorageable {
    private let realm = try! Realm()
    private let realmSubject = CurrentValueSubject<LocalStorageState, Never>(.success(items: []))
    
    init() {
        realmSubject.send(.success(items: readAll()))
    }
    
    func create(_ item: Todo) {
        write(.createFail) {
            realm.add(transferToTodoRealm(with: item))
            realmSubject.send(.success(items: readAll()))
        }
    }
        
    var todosPublisher: CurrentValueSubject<LocalStorageState, Never> {
        return realmSubject
    }
    
    func update(_ item: Todo) {
        write(.updateFail) {
            realm.add(transferToTodoRealm(with: item), update: .modified)
            realmSubject.send(.success(items: readAll()))
        }
    }
    
    func delete(_ item: Todo) {
        write(.deleteFail) {
            guard let realmModel = realm.object(ofType: TodoRealm.self, forPrimaryKey: item.id) else {
                return
            }
            realm.delete(realmModel)
            realmSubject.send(.success(items: readAll()))
        }
    }
    
    private func write(_ realmError: StorageError, _ work: () -> Void) {
        do {
            try realm.write { work() }
        } catch {
            realmSubject.send(.failure(error: realmError))
        }
    }
    
    private func readAll() -> [Todo] {
        return realm.objects(TodoRealm.self).map(transferToTodo)
    }
    
    private func transferToTodoRealm(with item: Todo) -> TodoRealm {
        return TodoRealm(
            title: item.title,
            content: item.content,
            deadline: item.deadline,
            processType: item.processType,
            id: item.id
        )
    }
    
    private func transferToTodo(with item: TodoRealm) -> Todo {
        return Todo(
            title: item.title,
            content: item.content,
            deadline: item.deadline,
            processType: item.processType,
            id: item.id
        )
    }
}
