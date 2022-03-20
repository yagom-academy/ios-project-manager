//
//  ProjectFirestoreBase.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/18.
//

import Foundation
import Firebase

enum FirestoreError: Error {
    
    case doucmentNotExist
}

class ProjectFirestoreBase {
    
    // MARK: - FirestorePath Namespace
    struct FirestorePath {
        static let collection = "projects"
    }
    
    let db = Firestore.firestore()
    
    // 추가
    func create(with content: [String: Any]) {
        guard let identifeir = content["identifier"] as? String else {
            return
        }
        var contentForFirestore = content
        guard let deadline = content["deadline"] as? Date,
            let status = content["status"] as? Status else {
            return
        }
        contentForFirestore.updateValue(Timestamp(date: deadline), forKey: "deadline")
        contentForFirestore.updateValue(status.rawValue, forKey: "statusString")
        
        db.collection(FirestorePath.collection).document(identifeir).setData(content) { err in
            if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
    
    // 읽기
    func read(with identifier: String, completion: @escaping (Result<[String: Any], FirestoreError>) -> Void) {
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
    
    // 일괄 읽기 (status)
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
    
    // 일괄 읽기
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
    
    // 선택 쓰기
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
    
    // 전체 일괄 쓰기
    func update(with projects: [[String: Any]]) {
        projects.forEach { project in
            guard let identifier = project["identifier"] as? String else {
                return
            }
            let projectRef = db.collection(FirestorePath.collection).document(identifier)
            
            projectRef.updateData(project) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    // 삭제
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
