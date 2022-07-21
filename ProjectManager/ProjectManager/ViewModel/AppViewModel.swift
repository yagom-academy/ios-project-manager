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
  var listViewModel: ListViewModel
//  var createViewModel: CreateViewModel
  
  init(todoService: TodoService = TodoService()) {
    
    self.todoService = todoService
    self.todoList = todoService.read()
    self.isTappedPlusButton = false
    self.listViewModel = ListViewModel(todoService: todoService)
//    self.createViewModel = CreateViewModel(create: { [self] todo in
//      self.todoService.creat(todo: todo)
//      todoList = todoService.read() })
  }
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    
    todoList = todoService.read()
  }
  
  func plusButtonTapped() {
    isTappedPlusButton = true
  }
}
