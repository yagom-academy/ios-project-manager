//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/10.
//

import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    
    // MARK: - Properties
    
    static let shared = FirebaseManager()
    private let firestore = Firestore.firestore()
    
    // MARK: - Life Cycle
    
    private init() { }
}

// MARK: - Methods

extension FirebaseManager {
    func fetchData(collection: String) -> Observable<[QueryDocumentSnapshot]> {
        Observable.create { emitter in
            FirebaseManager.shared.firestore.collection(collection).getDocuments { snapshot, error in
                
                guard let snapshot = snapshot else {
                    if let error = error { emitter.onError(error) }
                    return
                }
                
                emitter.onNext(snapshot.documents)
                emitter.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func sendData(collection: String, document: String, data: Todo) -> Observable<Void> {
        Observable.create { [weak self] emitter in
            do {
                try self?.firestore.collection(collection).document(document).setData(from: data) { error in
                    if let error = error {
                        emitter.onError(error)
                    }
                    emitter.onCompleted()
                }
            } catch {
                emitter.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func deleteTodoData(collection: String, document: String) -> Observable<Void> {
        Observable.create { [weak self] emitter in
            self?.firestore.collection(collection).document(document).delete { error in
                if let error = error {
                    emitter.onError(error)
                }
                emitter.onCompleted()
            }
            return Disposables.create()
        }
    }
}
