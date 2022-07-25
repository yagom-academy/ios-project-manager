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
    func todosPublisher() -> CurrentValueSubject<[Todo], StorageError>
}

final class FirebaseStorage: RemoteStorageable {
    private enum Constants {
        static let databaseURL = "https://projectmanager-42e08-default-rtdb.asia-southeast1.firebasedatabase.app"
        static let root = "todos"
        static let title = "title"
        static let content = "content"
        static let deadline = "deadline"
        static let processType = "processType"
        static let id = "id"
    }
    
    private lazy var databaseReference = Database.database(url: Constants.databaseURL).reference()
    private let firebaseSubject = CurrentValueSubject<[Todo], StorageError>([])
    private var cancellableBag = Set<AnyCancellable>()
    
    init() {
        readAll()
    }
    
    func backup(_ items: [Todo]) {
        deleteAll().sink { _ in
            
        } receiveValue: { _ in
            items.forEach {
                self.databaseReference
                    .child(Constants.root)
                    .child($0.id)
                    .setValue($0.toDictionary() as NSDictionary)
            }
        }
        .store(in: &cancellableBag)
    }
    
    func todosPublisher() -> CurrentValueSubject<[Todo], StorageError> {
        return firebaseSubject
    }
    
    private func readAll() {
        self.databaseReference.child(Constants.root).getData { error, snapshot in
            guard error == nil else {
                self.firebaseSubject.send(completion: .failure(.readFail))
                return
            }
            
            guard let value = snapshot?.value as? [String: Any] else {
                self.firebaseSubject.send(completion: .failure(.readFail))
                return
            }
            
            let items = value.compactMap { item -> Todo? in
                guard let item = item.value as? [String: Any] else {
                    return nil
                }
                
                guard let title = item[Constants.title] as? String,
                      let content = item[Constants.content] as? String,
                      let deadline = item[Constants.deadline] as? Double,
                      let processTypeValue = item[Constants.processType] as? String,
                      let processType = ProcessType(rawValue: processTypeValue),
                      let id = item[Constants.id] as? String
                else {
                    return nil
                }
                
                return Todo(
                    title: title,
                    content: content,
                    deadline: Date(timeIntervalSinceReferenceDate: deadline),
                    processType: processType,
                    id: id
                )
            }
            
            self.firebaseSubject.send(items)
        }
    }
    
    private func deleteAll() -> AnyPublisher<Void, StorageError> {
        return Future<Void, StorageError> { [weak self] observer in
            self?.databaseReference
                .child(Constants.root)
                .removeValue { error, _ in
                    guard error == nil else {
                        return observer(.failure(.deleteFail))
                    }
                    return observer(.success(()))
                }
        }.eraseToAnyPublisher()
    }
}
