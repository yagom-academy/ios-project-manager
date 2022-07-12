//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation

class AppViewModel: ObservableObject {
  @Published var todoService: TodoService
  
  init(todoService: TodoService) {
    self.todoService = todoService
  }
  
  func read() -> [Todo] {
    return todoService.todoList
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    let filteredTodo = todoService.todoList.filter { todo in
      todo.status == status
    }
    return filteredTodo
  }
  
  func creat(todo: Todo) {
    todoService.todoList.insert(Todo(title: todo.title, content: todo.content, status: .todo), at: 0)
  }
  
  func update(todo: Todo) {
    let willChangeTodo = todoService.todoList.filter { filteredTodo in
      todo.id == filteredTodo.id
    }
    
    willChangeTodo.first?.content = todo.content
    willChangeTodo.first?.title = todo.title
    willChangeTodo.first?.date  = todo.date
  }
}
