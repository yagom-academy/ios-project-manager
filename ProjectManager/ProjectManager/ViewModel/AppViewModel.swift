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
  @Published private var todoList: [Todo]
  @Published var isTappedPlusButton: Bool
  var todoListViewModel: ListViewModel
  var doingListViewModel: ListViewModel
  var doneListViewModel: ListViewModel
  lazy var createViewModel: CreateViewModel = CreateViewModel(todoService: todoService) { [self] in
    
    self.isTappedPlusButton = false
    self.todoList = todoService.read()
  }
  
  init(todoService: TodoService = TodoService()) {
    self.todoService = todoService
    self.todoList = todoService.read()
    self.isTappedPlusButton = false
    self.todoListViewModel = ListViewModel(todoService: todoService, status: .todo)
    self.doingListViewModel = ListViewModel(todoService: todoService, status: .doing)
    self.doneListViewModel = ListViewModel(todoService: todoService, status: .done)
  }
  
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    
    todoList = todoService.read()
  }
  
  func plusButtonTapped() {
    isTappedPlusButton = true
  }
}
