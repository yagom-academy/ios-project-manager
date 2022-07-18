//
//  RealmStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Combine

import RealmSwift

protocol Storageable: AnyObject {
    func create(_ item: Todo)
    func read() -> AnyPublisher<[Todo], Never>
    func update(_ item: Todo)
    func delete(_ item: Todo)
}

final class RealmStorage: Storageable {
    private let realm = try! Realm()
    private let realmSubject = CurrentValueSubject<[Todo], Never>([])
    
    init() {
        realmSubject.send(readAll())
    }
    
    func create(_ item: Todo) {
        let realmModel = TodoRealm(title: item.title, content: item.content, deadline: item.deadline, processType: item.processType, id: item.id)
        
        try! realm.write {
            realm.add(realmModel)
            realmSubject.send(readAll())
        }
    }
    
    func read() -> AnyPublisher<[Todo], Never> {
        return realmSubject.eraseToAnyPublisher()
    }
    
    func update(_ item: Todo) {
        let realmModel = TodoRealm(title: item.title, content: item.content, deadline: item.deadline, processType: item.processType, id: item.id)
        
        try! realm.write {
            realm.add(realmModel, update: .modified)
            realmSubject.send(readAll())
        }
    }
    
    func delete(_ item: Todo) {
        let realmModel = realm.object(ofType: TodoRealm.self, forPrimaryKey: item.id)!
        
        try! realm.write {
            realm.delete(realmModel)
            realmSubject.send(readAll())
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
