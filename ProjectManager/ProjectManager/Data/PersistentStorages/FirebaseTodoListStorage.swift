//
//  FirebaseTodoListStorage.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/21.
//

import Foundation
import FirebaseDatabase
import RxSwift

protocol RemoteBackUpStorage: AnyObject {
    func backUp(items: [TodoModel])
    func allRead() -> Single<[TodoModel]>
}

struct TodoFirebaseEntity {
    private let title: String
    private let deadlineAt: TimeInterval
    private let body: String
    private let id: String
    private let state: String
    
    init(value: [String: Any]) {
        self.title = value["title"] as? String ?? ""
        self.deadlineAt = value["deadlineAt"] as? TimeInterval ?? Date().timeIntervalSince1970
        self.body = value["body"] as? String ?? ""
        self.id = value["id"] as? String ?? UUID().uuidString
        self.state = value["state"] as? String ?? State.todo.rawValue
    }
    
    func toTodoModel() -> TodoModel {
        return TodoModel(title: title,
                         body: body,
                         deadlineAt: Date(timeIntervalSince1970: deadlineAt),
                         state: State(rawValue: state) ?? State.todo,
                         id: UUID(uuidString: id) ?? UUID())
    }
}

final class FirebaseTodoListStorage {
    private let database = Database
        .database(url: "https://todoapp-c1203-default-rtdb.asia-southeast1.firebasedatabase.app")
        .reference()
    
    private func allDelete() {
        database.removeValue()
    }
}

extension FirebaseTodoListStorage: RemoteBackUpStorage {
    func backUp(items: [TodoModel]) {
        allDelete()
        items.forEach { item in
            database.child(item.id.uuidString)
                .setValue(["title": item.title ?? "",
                           "deadlineAt": item.deadlineAt.timeIntervalSince1970,
                           "body": item.body ?? "",
                           "id": item.id.uuidString,
                           "state": item.state.rawValue])
        }
    }
    
    func allRead() -> Single<[TodoModel]>  {
        return Single.create { [weak self] single in
            var items: [TodoModel] = []
            self?.database.getData(completion: { error, snapshot in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                let data = snapshot?.value as! [String: [String: Any]]
                data.forEach { (_ , value: [String : Any]) in
                    let item = TodoFirebaseEntity(value: value).toTodoModel()
                    items.append(item)
                }
                single(.success(items))
            })
            return Disposables.create()
        }
    }
}
