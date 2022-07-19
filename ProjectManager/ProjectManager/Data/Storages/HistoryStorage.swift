//
//  HistoryStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Combine

import RealmSwift

protocol HistoryStorageable: AnyObject {
    func create(_ item: TodoHistory) -> AnyPublisher<Void, StorageError>
    func read() -> CurrentValueSubject<[TodoHistory], Never>
    func delete(_ item: TodoHistory) -> AnyPublisher<Void, StorageError>
}

final class HistoryStorage: HistoryStorageable {
    private let realm = try! Realm()
    private let realmSubject = CurrentValueSubject<[TodoHistory], Never>([])
    
    init() {
        realmSubject.send(readAll())
    }
    
    func create(_ item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        return write(.createFail) {
            realm.add(transferToTodoRealm(with: item))
            realmSubject.send(readAll())
        }
    }
        
    func read() -> CurrentValueSubject<[TodoHistory], Never> {
        return realmSubject
    }
    
    func delete(_ item: TodoHistory) -> AnyPublisher<Void, StorageError> {
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
    
    private func readAll() -> [TodoHistory] {
        return realm.objects(TodoHistoryRealm.self).map(transferToTodo).sorted { $0.createdAt > $1.createdAt }
    }
    
    private func transferToTodoRealm(with item: TodoHistory) -> TodoHistoryRealm {
        return TodoHistoryRealm(id: item.id, title: item.title, createdAt: item.createdAt)
    }
    
    private func transferToTodo(with item: TodoHistoryRealm) -> TodoHistory {
        return TodoHistory(title: item.title, createdAt: item.createdAt)
    }
}
