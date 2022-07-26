//
//  DataManager.swift
//  ProjectManager
//
//  Created by 박세리 on 2022/07/26.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager {
  var todos: [Todo] = []
  let db = Firestore.firestore()
  func readTodo() {
    todos.removeAll()
    

    let ref = db.collection("Todo")
    ref.getDocuments { snapShot, _ in
      
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
  
  func createTodo(todo: Todo) {
    
    db.collection("Todo").document(todo.id.uuidString).setData(["id": todo.id.uuidString,
                                                                "title": todo.title,
                                                                "content": todo.content,
                                                                "date": todo.date,
                                                                "status": todo.status.rawValue])
  }
  
  func updateTodo(status: Status, todo: Todo) {
    
    db.collection("Todo").document(todo.id.uuidString).updateData(["status": status.rawValue])
  }
  
  func updateTodo(todo: Todo) {
    
    db.collection("Todo").document(todo.id.uuidString).updateData(["id": "\(todo.id)",
                                                                       "title": todo.title,
                                                                       "content": todo.content,
                                                                       "date": todo.date,
                                                                       "status": todo.status.rawValue])
  }

  func deleteTodo() {
    
    db.collection("Todo").document("Jt0lnu78k2AyMpbP4GCN").delete { error in
      print("\(error)삭제가 안되!")
    }

  }
}
//
//func updateStatus(status: Status, todo: Todo) {
//
//  guard let realm = try? Realm() else { return }
//  guard let selectedTodo = realm.objects(TodoRealm.self).filter({ $0.id == todo.id }).first else {
//    return
//  }
//
//  try? realm.write {
//    selectedTodo.status = status
//  }
//}
//
//func update(todo: Todo) {
//  guard let realm = try? Realm() else { return }
//  guard let selectedTodo = realm.objects(TodoRealm.self).filter({ $0.id == todo.id }).first else {
//    return
//  }
//
//  try? realm.write {
//    selectedTodo.content = todo.content
//    selectedTodo.title = todo.title
//    selectedTodo.date = todo.date
//    selectedTodo.status = todo.status
//  }
//}

