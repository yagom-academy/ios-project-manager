//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
  var todoService: TodoService
  let navigationTitle: String
  @Published var todoList: [Todo]
  @Published var isTappedPlusButton: Bool
  
  lazy var todoListViewModel = ListViewModel(todoService: todoService,
                                             status: .todo,
                                             update: self.changeStatus)
  lazy var doingListViewModel = ListViewModel(todoService: todoService,
                                              status: .doing,
                                              update: self.changeStatus)
  lazy var doneListViewModel = ListViewModel(todoService: todoService,
                                             status: .done,
                                             update: self.changeStatus)
  lazy var createViewModel: CreateViewModel = CreateViewModel(todoService: todoService) { [self] in
    self.isTappedPlusButton = false
    self.todoList = todoService.read()
  }
  
  init(todoService: TodoService = TodoService(), navigationTitle: String = "Project Manager") {
    self.todoService = todoService
    self.navigationTitle = navigationTitle
    self.todoList = todoService.read()
    self.isTappedPlusButton = false
  }
  
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    todoList = todoService.read()
  }
  
  func plusButtonTapped() {
    isTappedPlusButton = true
  }
}
