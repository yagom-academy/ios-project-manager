//
//  TodoService.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation
import RealmSwift

class TodoService: ObservableObject {
  func creat(todo: Todo) {
    let realmData = TodoRealm()
    realmData.title = todo.title
    realmData.content = todo.content
    realmData.date = todo.date
    realmData.status = todo.status
    
    guard let realm = try? Realm() else {
      return
    }
    
    try? realm.write {
      realm.add(realmData)
    }
  }
  
  func read() -> [Todo] {
    guard let realm = try? Realm() else { return [] }
    let todoData = realm.objects(TodoRealm.self)
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
  
  func updateStatus(status: Status, todo: Todo) {
    
    guard let realm = try? Realm() else { return }
    guard let selectedTodo = realm.objects(TodoRealm.self).filter({ $0.id == todo.id }).first else {
      return
    }
    
    try? realm.write {
      selectedTodo.status = status
    }
  }
  
  func update(todo: Todo) {
    guard let realm = try? Realm() else { return }
    guard let selectedTodo = realm.objects(TodoRealm.self).filter({ $0.id == todo.id }).first else {
      return
    }
    
    try? realm.write {
      selectedTodo.content = todo.content
      selectedTodo.title = todo.title
      selectedTodo.date = todo.date
      selectedTodo.status = todo.status
    }
  }
  
  func delete(id: UUID) {
    guard let realm = try? Realm() else { return }
    try? realm.write {
      
      let selectedTodo = realm.objects(TodoRealm.self).filter { realm in
        realm.id == id
      }
      realm.delete(selectedTodo)
    }
  }
}
