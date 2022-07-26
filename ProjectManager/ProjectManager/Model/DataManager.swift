//
//  DataManager.swift
//  ProjectManager
//
//  Created by 박세리 on 2022/07/26.
//

import Foundation
import Firebase

class DataManager: ObservableObject {
  @Published var todos: [Todo] = []
  
  init() {
//    fetchTodo()
  }
  
  func fetchTodo() {
    todos.removeAll()
    let db = Firestore.firestore()
    let ref = db.collection("Todo")
    ref.getDocuments { snapShot, error in
//      guard error == nil else {
//        print("에러: \(error!.localizedDescription)")
//        return
//      }
      
      if let snapShot = snapShot {
        for documnet in snapShot.documents {
          let data = documnet.data()
          
          let id = data["id"] as? String ?? ""
          let title = data["title"] as? String ?? ""
          let content = data["content"] as? String ?? ""
          let date = data["date"] as? Date ?? Date()
          let status = data["status"] as? String ?? ""
          
          let todo = Todo(id: UUID(uuidString: id) ?? UUID(), title: title, content: content, date: date, status: Status(rawValue: status) ?? Status.todo)
          
          self.todos.append(todo)
          
        }
      }
    }
  }
}
