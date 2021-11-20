//
//  FirebaseStorage.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/12.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

enum FirebaseError: Error {
    case signingFailed
}

final class FirebaseStorage {
    private let db: Firestore = Firestore.firestore()
    private let dbCollectionRef: CollectionReference
    
    init() {
        dbCollectionRef = db.collection("Memos")
    }
    
    func put(_ memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        Auth.auth().signInAnonymously { [self] result, _ in
            guard let uid = result?.user.uid else {
                return completion(.failure(FirebaseError.signingFailed))
            }
            let batch = db.batch()
            
            do {
                let userDocRef = dbCollectionRef.document(uid)
                let memoRef = userDocRef.collection("UserMemos").document(memo.id.uuidString)
                batch.setData(["lastModified": Date()], forDocument: userDocRef)
                try batch.setData(from: memo, forDocument: memoRef)
            } catch {
                completion(.failure(error))
            }
            batch.commit { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(memo))
                }
            }
        }
    }
    
    func delete(_ memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        Auth.auth().signInAnonymously { [self] result, _ in
            guard let uid = result?.user.uid else {
                return completion(.failure(FirebaseError.signingFailed))
            }
            let batch = db.batch()
            
            let userDocRef = dbCollectionRef.document(uid)
            let memoRef = userDocRef.collection("UserMemos").document(memo.id.uuidString)
            batch.setData(["lastModified": Date()], forDocument: userDocRef)
            batch.deleteDocument(memoRef)
            batch.commit { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(memo))
                }
            }
        }
    }
    
    func fetch(completion: @escaping (Result<[Memo], Error>) -> Void) {
        Auth.auth().signInAnonymously { [self] result, _ in
            guard let uid = result?.user.uid else {
                return completion(.failure(FirebaseError.signingFailed))
            }
            
            dbCollectionRef
                .document(uid)
                .collection("UserMemos")
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        completion(.failure(error))
                    }
                    guard let querySnapshot = querySnapshot else {
                        return completion(.success([]))
                    }
                    let memos = querySnapshot
                        .documents
                        .compactMap { document in
                            try? document.data(as: Memo.self)
                        }
                    completion(.success(memos))
                }
        }
    }
}
