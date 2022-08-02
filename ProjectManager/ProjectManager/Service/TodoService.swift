//
//  TodoService.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation
import RealmSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

class TodoService {
  let dataManager: DataManager = DataManager()
//  var newtWorkCollection: Bool = true
  var historyStore: [HistoryModel] = []
  
  let realm = try? Realm()
  
  func creat(todo: Todo) {
    let realmData = TodoRealm()
    realmData.title = todo.title
    realmData.content = todo.content
    realmData.date = todo.date
    realmData.status = todo.status
    realmData.id = todo.id
    try? realm?.write {
      realm?.add(realmData)
    }
    
    dataManager.createTodo(todo: todo)
    
    let history = HistoryModel(title: todo.title, data: todo.date)
    historyStore.append(history)
  }
  
  func initUpdata(completion: @escaping (Result<Void, Error>) -> Void) {
    //    if newtWorkCollection {
    dataManager.readTodo { result in
      switch result {
      case .success(let data):
        try? self.realm?.write {
          self.realm?.deleteAll()
          for todo in data {
            let realmData = TodoRealm()
            realmData.title = todo.title
            realmData.content = todo.content
            realmData.date = todo.date
            realmData.status = todo.status
            realmData.id = todo.id
            self.realm?.add(realmData)
          }
          completion(.success(()))
        }
      case.failure(let error):
        completion(.failure(error))
      }
    }
    //    }
  }
  
  func read() -> [Todo] {
    guard let todoData = realm?.objects(TodoRealm.self) else {
      return []
    }
    let realArr = Array(todoData)
    let result = realArr.map { todoRealm -> Todo in
      
      return Todo(id: todoRealm.id,
                  title: todoRealm.title,
                  content: todoRealm.content,
                  date: todoRealm.date,
                  status: todoRealm.status)
    }
    return result
  }
  
  func read(by status: Status) -> [Todo] {
    let data = self.read()
    let filteredTodo = data.filter { todo in
      todo.status == status
    }
    return filteredTodo
  }
  
  func read(by todo: Todo) -> Todo {
    let todos = read()
    guard let filteredTodo = todos.first(where: { $0.id == todo.id }) else {
      return Todo(title: "", content: "")
    }
    return filteredTodo
  }
  
  func updateStatus(status: Status, todo: Todo) {
    
    guard let selectedTodo = realm?.objects(TodoRealm.self).first(where: { $0.id == todo.id }) else {
      return
    }
    
    try? realm?.write {
      selectedTodo.status = status
    }
    
    dataManager.updateTodo(status: status, todo: todo)
 
    let history = HistoryModel(action: .move,
                               title: todo.title,
                               originalStatus: todo.status,
                               nowStatus: status,
                               data: todo.date)
    historyStore.append(history)
 
  }
  
  func update(todo: Todo) {
   
    guard let selectedTodo = realm?.objects(TodoRealm.self).first(where: { $0.id == todo.id }) else {
      return
    }
    
    try? realm?.write {
      selectedTodo.content = todo.content
      selectedTodo.title = todo.title
      selectedTodo.date = todo.date
      selectedTodo.status = todo.status
    }
    
    dataManager.updateTodo(todo: todo)

    let history = HistoryModel(action: .edit,
                               title: todo.title,
                               originalStatus: todo.status,
                               nowStatus: nil,
                               data: todo.date)
    historyStore.append(history)
 
  }
  
  func delete(todo: Todo) {
    
    guard let selectedTodo = realm?.objects(TodoRealm.self).first(where: { $0.id == todo.id }) else {
      return
    }
    
    try? realm?.write {
      realm?.delete(selectedTodo)
    }
    
    dataManager.deleteTodo(todo: todo)

    let history = HistoryModel(action: .delete,
                               title: todo.title,
                               originalStatus: todo.status,
                               nowStatus: nil,
                               data: todo.date)
    historyStore.append(history)
  }
}
