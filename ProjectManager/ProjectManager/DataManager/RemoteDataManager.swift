//
//  RemoteDataManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/20.
//

import FirebaseCore
import FirebaseFirestore

final class RemoteDataManager {
    private let dataBase = Firestore.firestore()

    func add(todo: Todo) {
        dataBase.collection("Todo").document("\(todo.id)").setData([
            "category": "\(todo.category)",
            "title": "\(todo.title)",
            "body": "\(todo.body)",
            "date": todo.date
        ]) { err in
            if let err = err {
                print(err)
            } else {
                print("success add")
            }
        }
    }
    
    func read() {
        dataBase.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func delete(todo: Todo) {
        dataBase.collection("Todo").document("\(todo.id)").delete { err in
            if let err = err {
                print(err)
            } else {
                print("success delete")
            }
        }
    }
    
    func update(todo: Todo, with model: Todo) {
        dataBase.collection("Todo").document("\(todo.id)").setData([
            "category": "\(model.category)",
            "title": "\(model.title)",
            "body": "\(model.body)",
            "date": model.date
        ]) { err in
            if let err = err {
                print(err)
            } else {
                print("success add")
            }
        }
    }
    
    func move(todo: Todo, to target: String) {
        dataBase.collection("Todo").document("\(todo.id)").setData([
            "category": target,
            "title": "\(todo.title)",
            "body": "\(todo.body)",
            "date": todo.date
        ]) { err in
            if let err = err {
                print(err)
            } else {
                print("success add")
            }
        }
    }
}
