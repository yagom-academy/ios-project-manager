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
}

protocol Storageable: AnyObject {
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError>
    func read() -> CurrentValueSubject<[Todo], Never>
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError>
    func delete(_ item: Todo) -> AnyPublisher<Void, StorageError>
}

final class RealmStorage: Storageable {
    private let realm = try! Realm()
    private let realmSubject = CurrentValueSubject<[Todo], Never>([])
    
    init() {
        realmSubject.send(readAll())
    }
    
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return write(.createFail) {
            
            let realmModel = TodoRealm(title: item.title, content: item.content, deadline: item.deadline, processType: item.processType, id: item.id)
            realm.add(realmModel)
            realmSubject.send(self.readAll())
        }
    }
    
    func read() -> CurrentValueSubject<[Todo], Never> {
        return realmSubject
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return write(.updateFail) {
            let realmModel = TodoRealm(title: item.title, content: item.content, deadline: item.deadline, processType: item.processType, id: item.id)
            realm.add(realmModel, update: .modified)
            realmSubject.send(readAll())
        }
    }
    
    func delete(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return write(.deleteFail) {
            let realmModel = realm.object(ofType: TodoRealm.self, forPrimaryKey: item.id)!
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
        let todoRealms = realm.objects(TodoRealm.self)
        
        return todoRealms.map { realmModel in
            Todo(title: realmModel.title, content: realmModel.content
                 , deadline: realmModel.deadline, processType: realmModel.processType, id: realmModel.id)
        }
    }
}
