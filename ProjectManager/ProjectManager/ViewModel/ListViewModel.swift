//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/15.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
  var todoService: TodoService
  @Published var todoList: [Todo]
  
  lazy var editViewModel = EditViewModel(todoService: todoService) { [self] todo in
    todoService.update(todo: todo)
    todoList = todoService.read()
//    guard let index = todoList.firstIndex(where: { $0.id == todo.id }) else { return }
//        todoList[index].content = todo.content
//        todoList[index].title = todo.title
//        todoList[index].date  = todo.date
  }
  
  init(todoService: TodoService, todoList: [Todo]) {
    self.todoService = todoService
    self.todoList = todoList
  }
  
  func read(by status: Status) -> [Todo] {
    return todoService.read(by: status)
  }
  
  func delete(set: IndexSet, status: Status) {
    let filteredtodoList = self.todoService.read(by: status)

    guard let index = set.first else { return }
    
    let id = filteredtodoList[index].id
    
    todoService.delete(id: id)
    
    todoList = todoService.read()
  }
  
}
