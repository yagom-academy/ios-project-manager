//
//  DataManager.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/26.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

enum FirebaseError: Error {
  case unKnownError
}

class DataManager {
  
  let dataBase = Firestore.firestore()
  
  func readTodo(completionHandler: @escaping (Result<[Todo], FirebaseError>) -> Void) {
    var todoList: [Todo] = []
    todoList.removeAll()
    
    dataBase.collection("Todo").getDocuments { snapShot, error in

      guard let snapShot = snapShot else {
        print("non snapShot")
        return
      }
        for documnet in snapShot.documents {
          let data = documnet.data()
          
          let id = data["id"] as? String ?? ""
          let title = data["title"] as? String ?? ""
          let content = data["content"] as? String ?? ""
          let date = data["date"] as? Date ?? Date()
          let status = data["status"] as? String ?? ""
          
          let todo = Todo(id: UUID(uuidString: id) ?? UUID(),
                          title: title,
                          content: content,
                          date: date,
                          status: Status(rawValue: status) ?? Status.todo)
          todoList.append(todo)
        }
      completionHandler(.success(todoList))
    }
  }
  
  func createTodo(todo: Todo) {
    dataBase.collection("Todo")
      .document(todo.id.uuidString)
      .setData(["id": todo.id.uuidString,
                "title": todo.title,
                "content": todo.content,
                "date": todo.date,
                "status": todo.status.rawValue])
  }
  
  func updateTodo(status: Status, todo: Todo) {
    dataBase.collection("Todo")
      .document(todo.id.uuidString)
      .updateData(["status": status.rawValue])
  }
  
  func updateTodo(todo: Todo) {
    dataBase.collection("Todo")
      .document(todo.id.uuidString)
      .updateData(["id": "\(todo.id)",
                   "title": todo.title,
                   "content": todo.content,
                   "date": todo.date,
                   "status": todo.status.rawValue])
  }
  
  func deleteTodo(id: UUID) {
    dataBase.collection("Todo").document(id.uuidString).delete { _ in
    
    }
  }
}
