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
  
  lazy var editViewModel = EditViewModel { todos in
    self.closedEditView(element: todos)
  }
  
  init(todoService: TodoService, todo: Todo) {
    self.todoService = todoService
    self.todo = todo
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
