//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import Foundation

class EditViewModel: ObservableObject {
  @Published var todoService: TodoService
  
  init(todoService: TodoService) {
    self.todoService = todoService
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
