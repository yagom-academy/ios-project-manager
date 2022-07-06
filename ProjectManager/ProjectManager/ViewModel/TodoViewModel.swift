//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation

class TodoViewModel: ObservableObject {
  @Published private var todoList: [Todo] = [Todo(title: "firstTitle", content: "blablabla", status: .todo),
                                             Todo(title: "secondTitle", content: "heydaybay", status: .todo)]
  
  func read() -> [Todo] {
    return todoList
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    let filteredTodo = todoList.filter { todo in
      todo.status == status
    }
    return filteredTodo
  }
  
  func creat(todo: Todo) {
    todoList.insert(Todo(title: todo.title, content: todo.content, status: .todo), at: 0)
  }
}
