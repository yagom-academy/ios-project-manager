//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation

class TodoViewModel {
  private var todoList: [Todo] = []
  
  func read() -> [Todo] {
    return todoList
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    let filteredTodo = todoList.filter { todo in
      todo.status == status
    }
    return filteredTodo
  }
}
