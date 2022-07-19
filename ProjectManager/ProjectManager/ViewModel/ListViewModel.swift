//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/15.
//

import Foundation

class ListViewModel: ObservableObject {
  @Published var todoService: TodoService
  
  lazy var editViewModel = EditViewModel(todoService: todoService)
  
  init(todoService: TodoService) {
    self.todoService = todoService
  }
  
  func read(by status: Todo.Status) -> [Todo] {
    todoService.read(by: status)
  }
  
  func delete(set: IndexSet, status: Todo.Status) {
    let filteredtodoList = self.todoService.read(by: status)

    guard let index = set.first else { return }
    
    let id = filteredtodoList[index].id
    
    todoService.delete(id: id)
  }
  
}
