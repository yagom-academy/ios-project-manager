//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation
import SwiftUI

class CellButtonViewModel: ObservableObject {
  let todoService: TodoService
  var changeStatus: (Status, Todo) -> Void
  @Published var todo: Todo
  @Published var isShowPopover: Bool
  @Published var isShowEditView: Bool
 
  lazy var editViewModel = EditViewModel(todo: todo) { todos in
    self.closedEditView(element: todos)
  }

  lazy var popViewModel = PopoverViewModel(todo: todo, updata: changeStatus)
  
  lazy var cellContentViewModel = CellContentViewModel(todo: todo)
  
  init(
    todoService: TodoService,
    isShowPopover: Bool = false,
    isShowEditView: Bool = false,
    todo: Todo,
    changeStatus: @escaping (Status, Todo) -> Void) {
    self.todoService = todoService
    self.todo = todo
    self.changeStatus = changeStatus
    self.isShowPopover = isShowPopover
    self.isShowEditView = isShowEditView
  }
  
  func cellTapped() {
    isShowEditView = true
  }
  
  func cellLongTapped() {
    isShowPopover = true
  }
  
  func closedEditView(element: Todo) {
    self.todoService.update(todo: element)
    todo = self.todoService.read(by: element)
    isShowEditView = false
  }
  
  func closedModalView(status: Status, element: Todo) {
    self.todoService.updateStatus(status: status, todo: element)
    isShowPopover = false
  }
  
}
