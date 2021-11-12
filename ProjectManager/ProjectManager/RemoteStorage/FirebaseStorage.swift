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
    private var userId: String?
    private let db: Firestore = Firestore.firestore()
    private let dbCollectionRef: CollectionReference
    
    init() {
        dbCollectionRef = db.collection("Memos")
        Auth.auth().signInAnonymously { result, _ in
            self.userId = result?.user.uid
        }
    }
    
    func create(_ memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        guard let uid = userId else {
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
    
    func delete(_ memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        guard let uid = userId else {
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
