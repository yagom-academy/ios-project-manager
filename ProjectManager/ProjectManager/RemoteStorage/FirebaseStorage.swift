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
    
    func create(_ memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        Auth.auth().signInAnonymously { [self] result, _ in
            guard let uid = result?.user.uid else {
                return completion(.failure(FirebaseError.signingFailed))
            }
            
            do {
                try dbCollectionRef
                    .document(uid)
                    .collection("UserMemos")
                    .document(memo.id.uuidString)
                    .setData(from: memo)
                completion(.success(memo))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(_ memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        Auth.auth().signInAnonymously { [self] result, _ in
            guard let uid = result?.user.uid else {
                return completion(.failure(FirebaseError.signingFailed))
            }
            
            dbCollectionRef
                .document(uid)
                .collection("UserMemos")
                .document(memo.id.uuidString)
                .delete { error in
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
