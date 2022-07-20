//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
  var todoService: TodoService = TodoService()
  @Published private var todoList: [Todo] = []
  
  lazy var listViewModel = ListViewModel(todoService: todoService, todoList: todoList)
  lazy var createViewModel = CreateViewModel(create: { [self] todo in
    self.todoService.creat(todo: todo)
    todoList = todoService.read()
  })
  
  init() {
    todoList = todoService.read()
  }
  
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    
    todoList = todoService.read()
  }
}
