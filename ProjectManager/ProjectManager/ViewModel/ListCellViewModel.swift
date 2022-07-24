//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by 박세리 on 2022/07/23.
//

import Foundation
import SwiftUI

class ListCellViewModel: ObservableObject {
  var todoService: TodoService
  @Published var todo: Todo
  @Published var isShowModal = false
  @Published var isShowEditView = false
  var changeStatus: (Status, Todo) -> Void
  
  lazy var editViewModel = EditViewModel(todo: todo) { todos in
    self.closedEditView(element: todos)
  }
  
  lazy var popViewModel = PopViewModel(todo: todo, updata: changeStatus)
  
  init(todoService: TodoService, todo: Todo, changeStatus: @escaping (Status, Todo) -> Void) {
    self.todoService = todoService
    self.todo = todo
    self.changeStatus = changeStatus
  }
  
  func isTapped() {
    isShowEditView = true
  }
  
  func isLongPressed() {
    isShowModal = true
  }
  
  func closedEditView(element: Todo) {
    self.todoService.update(todo: element)
    todo = self.todoService.read(by: element)
    
    isShowEditView = false
  }
  
  func closedModalView(status: Status, element: Todo) {
    self.todoService.updateStatus(status: status, todo: element)
    isShowModal = false
  }
  
}
