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
    func readAll() -> Single<[TodoModel]>
}

final class FirebaseTodoListStorage {
    private let database = Database
        .database(url: "https://todoapp-c1203-default-rtdb.asia-southeast1.firebasedatabase.app")
        .reference()
    
    private func deleteAll() {
        database.removeValue()
    }
}

extension FirebaseTodoListStorage: RemoteBackUpStorage {
    func backUp(items: [TodoModel]) {
        deleteAll()
        items.forEach { item in
            database.child(item.id.uuidString)
                .setValue(["title": item.title ?? "",
                           "deadlineAt": item.deadlineAt.timeIntervalSince1970,
                           "body": item.body ?? "",
                           "id": item.id.uuidString,
                           "state": item.state.rawValue])
        }
    }
    
    func readAll() -> Single<[TodoModel]>  {
        return Single.create { [weak self] single in
            self?.database.getData(completion: { error, snapshot in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let data = snapshot?.value as? [String: [String: Any]] else {
                    single(.success([]))
                    return
                }
                let items = data.map { TodoFirebaseEntity(value: $1).toTodoModel() }
                
                single(.success(items))
            })
            return Disposables.create()
        }
    }
}
