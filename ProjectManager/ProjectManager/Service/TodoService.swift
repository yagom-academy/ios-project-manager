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
//    todoList.insert(Todo(title: todo.title, content: todo.content, status: .todo), at: 0)
    let realmData = TodoRealm()
    realmData.title = todo.title
    realmData.content = todo.content
    realmData.date = todo.date
    realmData.status = todo.status.rawValue

    guard let realm = try? Realm() else { return }
    try? realm.write {
      realm.add(realmData)
    }
  }
  
//  func insert(todo: Todo) {
//    todoList.insert(todo, at: 0)
//  }
  
  func read() -> [Todo] {
//    return todoList
    guard let realm = try? Realm() else { return [] }
    let todoData = realm.objects(TodoRealm.self)
    let realArr = Array(todoData)
    let result = realArr.map { todoRealm -> Todo in
      guard let status = Todo.Status(rawValue: todoRealm.status) else { return Todo(title: "뭔가", content: "잘못됨") }
      return Todo(id: todoRealm.id,
           title: todoRealm.title,
           content: todoRealm.content,
           date: todoRealm.date,
           status: status)
    }
    return result
  }
  
  func read(by status: Todo.Status) -> [Todo] {
//    let filteredTodo = read().filter { todo in
//      todo.status == status
//    }
//    return filteredTodo
    let data = self.read()
    let filteredTodo = data.filter { todo in
      todo.status == status
    }
    return filteredTodo
  }
  
  func update(todo: Todo) {
    guard let index = todoList.firstIndex(where: { $0.id == todo.id }) else { return }
    todoList[index].content = todo.content
    todoList[index].title = todo.title
    todoList[index].date  = todo.date
    todoList[index].status = todo.status
  }
  
  func delete(id: UUID) {
    todoList.removeAll { todo in
      todo.id == id
    }
  }
}
