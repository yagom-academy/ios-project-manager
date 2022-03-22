//
//  ProjectFirestoreManager.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/18.
//

import Foundation
import Firebase

enum FirestoreError: Error {
    
    case readFail
    case invalidDeadline
}

final class ProjectFirestoreManager {
    
    // MARK: - FirestorePath Namespace
    struct FirestorePath {
        static let collection = "projects"
    }
    
    // MARK: - Property
    let db = Firestore.firestore()
    
    // MARK: - Method
    func readAll(completion: @escaping (Result<[[String: Any]?], FirestoreError>) -> Void) {
        db.collection(FirestorePath.collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.readFail))
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
    
    private func formatProjectToJSONDict(with dict: [String: Any]) -> [String: Any] {
        let project = Project(identifier: dict["identifier"] as? String,
                              title: dict["title"] as? String,
                              deadline: dict["deadline"] as? Date,
                              description: dict["description"] as? String,
                              status: dict["status"] as? Status)
        
        let dict = project.jsonObjectToDictionary(of: project)
        return dict
    }
}

// MARK: - DataSource
extension ProjectFirestoreManager: DataSource {
    
    // MARK: - Method
    func create(with content: [String : Any]) {
        guard let identifeir = content["identifier"] as? String,
              let deadline = content["deadline"] as? Date else {
                  return
              }
        
        var dict = self.formatProjectToJSONDict(with: content)
        dict.updateValue(Timestamp(date: deadline), forKey: "deadline")
        
        db.collection(FirestorePath.collection).document(identifeir).setData(dict) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func read(of identifier: String, completion: @escaping (Result<Project?, Error>) -> Void) {
        let docRef = db.collection(FirestorePath.collection).document(identifier)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let dict = document.data() {
                    guard let deadline = dict["deadline"] as? Timestamp else {
                        completion(.failure(FirestoreError.invalidDeadline))
                        return
                    }
                    
                    let deadlineDate = Date(timeIntervalSince1970: TimeInterval(deadline.seconds))
                    let project = Project(identifier: dict["identifier"] as? String,
                                          title: dict["title"] as? String,
                                          deadline: deadlineDate,
                                          description: dict["description"] as? String,
                                          status: dict["status"] as? Status)
                    completion(.success(project))
                }
            } else {
                print("Document does not exist")
                completion(.failure(FirestoreError.readFail))
            }
        }
    }
    
    func read(of group: Status, completion: @escaping (Result<[Project]?, Error>) -> Void) {
        db.collection(FirestorePath.collection).whereField("status", isEqualTo: group.rawValue)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(.failure(FirestoreError.readFail))
                } else {
                    var dicts: [[String: Any]] = []
                    for document in querySnapshot!.documents {
                        dicts.append(document.data())
                    }
                    let projects = dicts.compactMap { (dict: [String: Any]) -> Project? in
                        guard let deadline = dict["deadline"] as? Timestamp else {
                            completion(.failure(FirestoreError.invalidDeadline))
                            return nil
                        }
                        
                        let deadlineDate = Date(timeIntervalSince1970: TimeInterval(deadline.seconds))
                        return Project(identifier: dict["identifier"] as? String,
                                       title: dict["title"] as? String,
                                       deadline: deadlineDate,
                                       description: dict["description"] as? String,
                                       status: dict["status"] as? Status)
                    }
                    completion(.success(projects))
                }
            }
    }
    
    func updateContent(of identifier: String, with content: [String : Any]) {
        let projectRef = db.collection(FirestorePath.collection).document(identifier)
        
        guard let deadlineDate = content["deadline"] as? Date else {
            return
        }
        
        var updatingContent = content
        updatingContent.updateValue(Timestamp(date: deadlineDate), forKey: "deadline")
        
        projectRef.updateData(updatingContent) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func updateStatus(of identifier: String, with status: Status) {
        let projectRef = db.collection(FirestorePath.collection).document(identifier)
        
        var updatingContent: [String: Any] = [:]
        updatingContent.updateValue(status.rawValue, forKey: "status")
        
        projectRef.updateData(updatingContent) { err in
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
