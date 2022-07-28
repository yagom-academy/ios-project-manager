//
//  HistoryStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Combine

import RealmSwift

enum HistoryStorageState {
    case success(items: [TodoHistory])
    case failure(error: StorageError)
}

protocol HistoryStorageable: AnyObject {
    func create(_ item: TodoHistory)
    func todoHistoriesPublisher() -> CurrentValueSubject<HistoryStorageState, Never>
    func delete(_ item: TodoHistory)
}

final class HistoryStorage: HistoryStorageable {
    private let realm = try! Realm()
    private let realmSubject = CurrentValueSubject<HistoryStorageState, Never>(.success(items: []))
    
    init() {
        realmSubject.send(.success(items: readAll()))
    }
    
    func create(_ item: TodoHistory) {
        write(.createFail) {
            realm.add(transferToTodoRealm(with: item))
            realmSubject.send(.success(items: readAll()))
        }
    }
        
    func todoHistoriesPublisher() -> CurrentValueSubject<HistoryStorageState, Never> {
        return realmSubject
    }
    
    func delete(_ item: TodoHistory) {
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
