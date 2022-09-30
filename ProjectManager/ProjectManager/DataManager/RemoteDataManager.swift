//
//  RemoteDataManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/20.
//

import FirebaseCore
import FirebaseFirestore

final class RemoteDataManager: RemoteRepositoryConnectable {
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
    
    func read(_ completion: @escaping ([Todo]) -> Void) {
        dataBase.collection("Todo").getDocuments { [weak self] (querySnapshot, err) in
            guard let self = self else { return }
            guard err == nil, let querySnapshot = querySnapshot else {
                print(err!)
                return
            }
            completion(self.translateRemoteData(querySnapshot.documents))
        }
    }
    
    private func translateRemoteData(_ list: [QueryDocumentSnapshot]) -> [Todo] {
        var todoList: [Todo] = []
        for document in list {
            let timestamp = document.data()["date"] as? Timestamp ?? Timestamp()
            let todo = Todo(
                id: UUID(uuidString: document.documentID) ?? UUID(),
                category: document.data()["category"] as? String ?? "",
                title: document.data()["title"] as? String ?? "",
                body: document.data()["body"] as? String ?? "",
                date: timestamp.dateValue()
            )
            todoList.append(todo)
        }
        return todoList
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
    
    func update(todo: Todo, with model: TodoModel) {
        dataBase.collection("Todo").document("\(todo.id)").setData([
            "category": "\(model.category)",
            "title": "\(model.title)",
            "body": "\(model.body)",
            "date": model.date
        ]) { err in
            if let err = err {
                print(err)
            } else {
                print("success update")
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
