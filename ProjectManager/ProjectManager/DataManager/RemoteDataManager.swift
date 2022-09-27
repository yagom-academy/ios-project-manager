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
        dataBase.collection("Todo").getDocuments { [weak self] (querySnapshot, err) in
            guard err == nil, let querySnapshot = querySnapshot else {
                print(err!)
                return
            }
            self?.translateRemoteData(querySnapshot.documents)
        }
    }
    
    private func translateRemoteData(_ list: [QueryDocumentSnapshot]) {
        for document in list {
            let timestamp = document.data()["date"] as? Timestamp ?? Timestamp()
            let todo = Todo()
            todo.id = UUID(uuidString: document.documentID) ?? UUID()
            todo.category = document.data()["category"] as? String ?? ""
            todo.title = document.data()["title"] as? String ?? ""
            todo.body = document.data()["body"] as? String ?? ""
            todo.date = timestamp.dateValue()
            TodoDataManager.shared.setupInitialData(with: todo)
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
                print("success move")
            }
        }
    }
}
