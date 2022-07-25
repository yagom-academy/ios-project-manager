//
//  AppViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
  let todoService: TodoService
  let navigationTitle: String
  @Published var todoList: [Todo]
  @Published var isShowCreateView: Bool
  
  var todoListViewModel: ListViewModel {
    return ListViewModel(todoService: todoService, status: .todo, update: self.changeStatus) }
  var doingListViewModel: ListViewModel {
    return ListViewModel(todoService: todoService, status: .doing, update: self.changeStatus) }
  var doneListViewModel: ListViewModel {
    return ListViewModel(todoService: todoService, status: .done, update: self.changeStatus) }
  
  var createViewModel: CreateViewModel {
    return  CreateViewModel(todoService: todoService, todoList: todoList) { self.isShowCreateView = false }
  }
  
  init(todoService: TodoService = TodoService(), navigationTitle: String = "Project Manager") {
    self.todoService = todoService
    self.navigationTitle = navigationTitle
    self.todoList = todoService.read()
    self.isShowCreateView = false
  }
  
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    todoList = todoService.read()
  }
  
  func plusButtonTapped() {
    isShowCreateView = true
  }
}
