//
//  FirebaseStorage.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/18.
//

import Combine

import RealmSwift
import FirebaseDatabase

protocol RemoteStorageable: AnyObject {
    func backup(_ items: [Todo])
    func read() -> CurrentValueSubject<[Todo], StorageError>
}

final class FirebaseStorage: RemoteStorageable {
    private let databaseURL = "https://projectmanager-42e08-default-rtdb.asia-southeast1.firebasedatabase.app"
    private lazy var databaseReference = Database.database(url: databaseURL).reference()
    private let firebaseSubject = CurrentValueSubject<[Todo], StorageError>([])
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        readAll()
    }
    
    func backup(_ items: [Todo]) {
        deleteAll().sink { completion in
            
        } receiveValue: { _ in
            items.forEach {
                self.databaseReference
                    .child("todos")
                    .child($0.id)
                    .setValue($0.toDictionary() as NSDictionary)
            }
        }
        .store(in: &cancelBag)
    }
    
    func read() -> CurrentValueSubject<[Todo], StorageError> {
        return firebaseSubject
    }
    
    private func readAll() {
        self.databaseReference.child("todos").getData { error, snapshot in
            guard error == nil else {
                self.firebaseSubject.send(completion: .failure(.readFail))
                return
            }
            
            let value = snapshot?.value as? [String: Any]
            let items = value?.compactMap { item -> Todo in
                let value = item.value as? [String: Any]
                return Todo(
                    title: value?["title"] as! String,
                    content: value?["content"] as! String,
                    deadline: Date(timeIntervalSinceReferenceDate: value?["deadline"] as! Double),
                    processType: .todo,
                    id: value?["id"] as! String
                )
            }
            
            self.firebaseSubject.send(items!)
            print(snapshot)
            print("items", items)
            
        }
    }
    
    private func deleteAll() -> AnyPublisher<Void, StorageError> {
        return Future<Void, StorageError> { [weak self] observer in
            self?.databaseReference
                .child("todos")
                .removeValue(completionBlock: { error, reference in
                    guard error == nil else {
                        return observer(.failure(.deleteFail))
                    }
                    return observer(.success(()))
                })
        }.eraseToAnyPublisher()
    }
}
