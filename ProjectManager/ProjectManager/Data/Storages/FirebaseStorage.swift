//
//  FirebaseStorage.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/18.
//

import Combine

import RealmSwift
import FirebaseDatabase
import SwiftUI

final class FirebaseStorage: Storageable {
    private let databaseURL = "https://projectmanager-42e08-default-rtdb.asia-southeast1.firebasedatabase.app"
    private lazy var databaseReference = Database.database(url: databaseURL).reference()
    private let firebaseSubject = CurrentValueSubject<[Todo], Never>([])
    
    init() {
        registerFirebaseDatabaseObserver()
    }
    
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return Future<Void, StorageError> { [weak self] observer in
            self?.databaseReference
                .child("todos")
                .child(item.id)
                .setValue(item.toDictionary() as NSDictionary) { (error: Error?, _: DatabaseReference) in
                    guard error == nil else {
                        return observer(.failure(.createFail))
                    }
                    
                    return observer(.success(()))
                }
        }.eraseToAnyPublisher()
    }
    
    func read() -> CurrentValueSubject<[Todo], Never> {
        return firebaseSubject
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return Future<Void, StorageError> { [weak self] observer in
            guard let key = self?.databaseReference.child("todos").child(item.id).key else {
                return observer(.failure(.updateFail))
            }
            
            let childUpdates = ["/todos/\(key)": item.toDictionary()]
            self?.databaseReference.updateChildValues(childUpdates) { (error: Error?, _: DatabaseReference) in
                guard error == nil else {
                    return observer(.failure(.updateFail))
                }
                
                return observer(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func delete(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        return Future<Void, StorageError> { [weak self] observer in
            self?.databaseReference
                .child("todos")
                .child(item.id)
                .removeValue { (error: Error?, _: DatabaseReference) in
                guard error == nil else {
                    return observer(.failure(.deleteFail))
                }
                
                return observer(.success(()))
            }
        }.eraseToAnyPublisher()
    }

    private func registerFirebaseDatabaseObserver() {
        self.databaseReference.child("todos").observe(.value, with: { snapshot in
            let value = snapshot.value as? [String: Any]
            let items = value?.map { item -> Todo in
                let value = item.value as? [String: Any]
                return Todo(
                    title: value?["title"] as! String,
                    content: value?["content"] as! String,
                    deadline: Date(timeIntervalSinceReferenceDate: value?["deadline"] as! Double),
                    processType: .todo,
                    id: value?["id"] as! String
                )
            }.sorted { $0.deadline < $1.deadline }
            
            self.firebaseSubject.send(items ?? [])
        }, withCancel: { error in
            print(error.localizedDescription)
        })
    }
}
