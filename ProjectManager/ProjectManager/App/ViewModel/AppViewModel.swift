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
  @Published var isShowAlerView: Bool
  var willError: LocalizedError?
  
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
    self.isShowHistoryView = false
    self.isShowAlerView = false
    self.navigationTitle = navigationTitle
    self.todoList = todoService.read()
    self.isShowCreateView = false
    self.todoService.initUpdata { [self] result in
      switch result {
      case .success:
        break
      case .failure(let error):
        self.willError = error
        self.isShowAlerView = true
        // alert 에 대한 내용 추가
      }
    }
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
    todoService.initUpdata { result in
      switch result {
      case .success:
        self.todoList = self.todoService.read()
        self.todoListViewModel.refrash()
        self.doingListViewModel.refrash()
        self.doneListViewModel.refrash()
      case .failure(let error):
        self.willError = error
        self.isShowAlerView = true
        // alert 정보를 어떻게 넘기지?
      }
    }
  }
  
  func cloaseAlert() {
    isShowAlerView = false
  }
  
}
