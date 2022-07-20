//
//  TodoService.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation
import RealmSwift

class TodoService: ObservableObject {
  @Published private var todoList: [Todo] = []
  
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
    
    todoList = self.read()
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
  
  func update(todo: Todo) {
    guard let realm = try? Realm() else { return }
    let asd = realm.objects(TodoRealm.self).filter { realm in
      realm.id == todo.id
    }

    guard let qweqwe = asd.first else {
      return
    }
    
    try? realm.write {
      qweqwe.content = todo.content
      qweqwe.title = todo.title
      qweqwe.date = todo.date
      qweqwe.status = todo.status
    }
    
    guard let index = todoList.firstIndex(where: { $0.id == todo.id }) else { return }
    todoList[index].content = todo.content
    todoList[index].title = todo.title
    todoList[index].date  = todo.date
    todoList[index].status = todo.status
    
    todoList = self.read()
  }
  
  func delete(id: UUID) {
    guard let realm = try? Realm() else { return }
    try? realm.write {
      
      let asd = realm.objects(TodoRealm.self).filter { realm in
        realm.id == id
      }
      realm.delete(asd)
    }
    
    todoList.removeAll { todo in
      todo.id == id
    }
    
    todoList = self.read()
  }
}
