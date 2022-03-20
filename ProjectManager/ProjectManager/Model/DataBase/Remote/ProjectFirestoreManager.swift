//
//  ProjectFirestoreManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/18.
//

import Foundation
import Firebase

enum FirestoreError: Error {
    
    case doucmentNotExist
}

final class ProjectFirestoreManager {
    
    // MARK: - FirestorePath Namespace
    struct FirestorePath {
        static let collection = "projects"
    }
    
    // MARK: - Property
    let db = Firestore.firestore()
    
    // MARK: - Method
    func read(of status: Status, completion: @escaping (Result<[[String: Any]], FirestoreError>) -> Void) {
        db.collection(FirestorePath.collection).whereField("status", isEqualTo: status)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(.failure(.doucmentNotExist))
                } else {
                    var datas: [[String: Any]] = []
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        datas.append(document.data())
                    }
                    completion(.success(datas))
                }
        }
    }
    
    func readAll(completion: @escaping (Result<[[String: Any]?], FirestoreError>) -> Void) {
        db.collection(FirestorePath.collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.doucmentNotExist))
            } else {
                var datas: [[String: Any]] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    datas.append(document.data())
                }
                completion(.success(datas))
            }
        }
    }
    
    private func formatToJSONDict(with dict: [String: Any]) -> [String: Any] {
        let project = Project(identifier: dict["identifier"] as? String,
                              title: dict["title"] as? String,
                              deadline: dict["deadline"] as? Date,
                              description: dict["description"] as? String,
                              status: dict["status"] as? Status)
        
        // TODO: - Util로 구현하기
        guard let data = try? JSONEncoder().encode(project),
              let dict = try? JSONSerialization.jsonObject(
                with: data,
                options: []) as? [String: Any] else {
                  return [:]
              }
        return dict
    }
}

// MARK: - RemoteDataManagable
extension ProjectFirestoreManager: RemoteDataManagable {
    
    typealias Item = Project
    
    func create(with content: [String : Any]) {
        guard let identifeir = content["identifier"] as? String,
              let deadline = content["deadline"] as? Date else {
            return
        }
        
        var dict = self.formatToJSONDict(with: content)
        dict.updateValue(Timestamp(date: deadline), forKey: "deadline")
        
        db.collection(FirestorePath.collection).document(identifeir).setData(content) { err in
            if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
    
    func read(of identifier: String, completion: @escaping (Result<[String : Any], FirestoreError>) -> Void) {
        let docRef = db.collection(FirestorePath.collection).document(identifier)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    print("Document data: \(String(describing: data))")
                    completion(.success(data))
                    return
                }
            } else {
                print("Document does not exist")
                completion(.failure(.doucmentNotExist))
            }
        }
    }
    
    func update(of identifier: String, with content: [String: Any]) {
        let projectRef = db.collection(FirestorePath.collection).document(identifier)

        projectRef.updateData(content) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func delete(of identifier: String) {
        db.collection(FirestorePath.collection).document(identifier).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
