//
//  TodoService.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class TodoService: ObservableObject {
  @Published private var todoList: [Todo] = [
    Todo(title: "1Title", content: "blablabla", status: .todo),
    Todo(title: "2Title", content: "blablabla", status: .doing),
    Todo(title: "3Title", content: "blablabla", status: .doing),
    Todo(title: "4Title", content: "blablabla", status: .done),
    Todo(title: "5Title", content: "blablabla", status: .doing),
    Todo(title: "6Title", content: "blablabla", status: .todo),
    Todo(title: "7Title", content: "blablabla", status: .todo),
    Todo(title: "8Title", content: "blablabla", status: .doing),
    Todo(title: "9Title", content: "blablabla", status: .done),
    Todo(title: "10Title", content: "blablabla", status: .todo),
    Todo(title: "11Title", content: "blablabla", status: .done),
    Todo(title: "12Title", content: "blablabla", status: .todo),
    Todo(title: "13Title", content: "heydaybay", status: .done)
  ]
  
  func creat(todo: Todo) {
    todoList.insert(Todo(title: todo.title, content: todo.content, status: .todo), at: 0)
  }
  
  func read() -> [Todo] {
    return todoList
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    let filteredTodo = read().filter { todo in
      todo.status == status
    }
    return filteredTodo
  }
  
  func update(todo: Todo) {
    let willChangeTodo = todoList.filter { filteredTodo in
      todo.id == filteredTodo.id
    }
    
    willChangeTodo.first?.content = todo.content
    willChangeTodo.first?.title = todo.title
    willChangeTodo.first?.date  = todo.date
    willChangeTodo.first?.status = todo.status
  }
  
  func delete(todo: Todo) {
    todoList.removeAll { list in
      list.id == todo.id
    }
  }
}
