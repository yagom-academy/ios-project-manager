//
//  RealmStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Combine

import RealmSwift

typealias RealmResult = Result<Void, RealmError>

enum RealmError: Error {
    case createFail
    case updateFail
    case detailFail
}

protocol Storageable: AnyObject {
    func create(_ item: Todo) -> AnyPublisher<Void, RealmError>
    func read() -> CurrentValueSubject<[Todo], Never>
    func update(_ item: Todo) -> AnyPublisher<Void, RealmError>
    func delete(_ item: Todo) -> AnyPublisher<Void, RealmError>
}

final class RealmStorage: Storageable {
    private let realm = try! Realm()
    private let realmSubject = CurrentValueSubject<[Todo], Never>([])
    
    init() {
        realmSubject.send(readAll())
    }
    
    func create(_ item: Todo) -> AnyPublisher<Void, RealmError> {
        return write(.createFail) {
            
            let realmModel = TodoRealm(title: item.title, content: item.content, deadline: item.deadline, processType: item.processType, id: item.id)
            realm.add(realmModel)
            realmSubject.send(self.readAll())
        }
    }
    
    func read() -> CurrentValueSubject<[Todo], Never> {
        return realmSubject
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, RealmError> {
        return write(.updateFail) {
            let realmModel = TodoRealm(title: item.title, content: item.content, deadline: item.deadline, processType: item.processType, id: item.id)
            realm.add(realmModel, update: .modified)
            realmSubject.send(readAll())
        }
    }
    
    func delete(_ item: Todo) -> AnyPublisher<Void, RealmError> {
        return write(.detailFail) {
            let realmModel = realm.object(ofType: TodoRealm.self, forPrimaryKey: item.id)!
            realm.delete(realmModel)
            realmSubject.send(readAll())
        }
    }
    
    private func write(_ realmError: RealmError, _ work: () -> Void) -> AnyPublisher<Void, RealmError> {
        do {
            try realm.write { work() }
            return Empty<Void, RealmError>().eraseToAnyPublisher()
        } catch {
            return Fail<Void, RealmError>(error: realmError).eraseToAnyPublisher()
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
