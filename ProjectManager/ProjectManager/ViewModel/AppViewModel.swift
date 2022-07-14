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
  
  private func create(todo: Todo) {
    todoService.creat(todo: todo)
  }
  
  func read() -> [Todo] {
    return todoService.read()
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    todoService.read(by: status)
  }
  
  func changeStatus(status: Todo.Status, todo: Todo) {
    todoService.delete(id: todo.id)
    todo.status = status
    self.todoService.insert(todo: todo)
  }
  
  func delete(set: IndexSet, status: Todo.Status) {
    let filteredtodoList = self.read(by: status)

    guard let index = set.first else { return }
    
    let id = filteredtodoList[index].id
    
    todoService.delete(id: id)
  }

}
