//
//  RealmStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Combine

import RealmSwift

enum StorageError: Error {
    case createFail
    case updateFail
    case deleteFail
    case readFail
}

protocol LocalStorageable: AnyObject {
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError>
    func read() -> CurrentValueSubject<[Todo], Never>
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError>
    func delete(_ item: Todo) -> AnyPublisher<Void, StorageError>
}

final class RealmStorage: LocalStorageable {
    private let realm = try! Realm()
    private let realmSubject = CurrentValueSubject<[Todo], Never>([])
    
    init() {
        realmSubject.send(readAll())
    }
    
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return write(.createFail) {
            realm.add(transferToTodoRealm(with: item))
            realmSubject.send(self.readAll())
        }
    }
        
    func read() -> CurrentValueSubject<[Todo], Never> {
        return realmSubject
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return write(.updateFail) {
            realm.add(transferToTodoRealm(with: item), update: .modified)
            realmSubject.send(readAll())
        }
    }
    
    func delete(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return write(.deleteFail) {
            guard let realmModel = realm.object(ofType: TodoRealm.self, forPrimaryKey: item.id) else {
                return
            }
            realm.delete(realmModel)
            realmSubject.send(readAll())
        }
    }
    
    private func write(_ realmError: StorageError, _ work: () -> Void) -> AnyPublisher<Void, StorageError> {
        do {
            try realm.write { work() }
            return Empty<Void, StorageError>().eraseToAnyPublisher()
        } catch {
            return Fail<Void, StorageError>(error: realmError).eraseToAnyPublisher()
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
