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
  @Published var isShowHistoryView: Bool
  
  var todoListViewModel: ListViewModel {
    return ListViewModel(todoService: todoService, status: .todo, update: self.changeStatus) }
  var doingListViewModel: ListViewModel {
    return ListViewModel(todoService: todoService, status: .doing, update: self.changeStatus) }
  var doneListViewModel: ListViewModel {
    return ListViewModel(todoService: todoService, status: .done, update: self.changeStatus) }
  
  var createViewModel: CreateViewModel {
    return CreateViewModel(todoService: todoService, todoList: todoList) { self.isShowCreateView = false
    }
  }
  
  var historyViewModel: HistoryViewModel {
    return HistoryViewModel(todoService: todoService)
  }
  
  init(todoService: TodoService = TodoService(), navigationTitle: String = "Project Manager") {
    self.todoService = todoService
    self.todoService.initUpdata {}
    self.navigationTitle = navigationTitle
    self.todoList = todoService.read()
    self.isShowCreateView = false
    self.isShowHistoryView = false
  }
  
  func changeStatus(status: Status, todo: Todo) {
    todoService.updateStatus(status: status, todo: todo)
    todoList = todoService.read()
  }
  
  func plusButtonTapped() {
    isShowCreateView = true
  }

  func historyButtonTapped() {
    isShowHistoryView = true
  }

  func syncRemoteDatabase() {
    todoService.initUpdata {
      self.todoList = self.todoService.read()
      self.todoListViewModel.refrash()
      self.doingListViewModel.refrash()
      self.doneListViewModel.refrash()
    }
  }
}
