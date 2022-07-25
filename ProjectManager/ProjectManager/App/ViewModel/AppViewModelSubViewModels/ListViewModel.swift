//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/15.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
  let todoService: TodoService
  let status: Status
  @Published var listCount: Int
  @Published var todoList: [Todo]
  var update: (Status, Todo) -> Void
 
  init(todoService: TodoService, status: Status, update: @escaping (Status, Todo) -> Void) {
    self.todoService = todoService
    self.status = status
    self.todoList = todoService.read(by: status)
    self.listCount = todoService.read(by: status).count
    self.update = update
  }
  
  func delete(set: IndexSet) {
    let filteredtodoList = self.todoService.read(by: status)
    
    guard let index = set.first else { return }
    
    let id = filteredtodoList[index].id
    
    todoService.delete(id: id)
    
    self.refrash()
  }

  func closeButtonTapped() {
    todoList = todoService.read(by: status)
  }
  
  func updata(status: Status, todo: Todo) {
    self.update(status, todo)
    listCount = todoService.read(by: status).count
  }

  func refrash() {
    todoList = todoService.read(by: status)
    listCount = todoService.read(by: status).count
  }
  
  func makeCellViewModel(todo: Todo) -> CellButtonViewModel {
    return CellButtonViewModel(todoService: todoService, todo: todo, changeStatus: update)
  }
}
