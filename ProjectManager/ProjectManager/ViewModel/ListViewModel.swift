//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/15.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
  var todoService: TodoService
  let status: Status
  var listCount: Int
  @Published var todoList: [Todo]
  @Published var isLongPressing = false
  @Published var isShowEditView = false
  
  lazy var editViewModel = EditViewModel(update: { [self] todo in
    todoService.update(todo: todo)
    todoList = todoService.read(by: status)
  })
 
  init(todoService: TodoService, status: Status) {
    self.todoService = todoService
    self.status = status
    self.todoList = todoService.read(by: status)
    self.listCount = todoService.read(by: status).count
  }
  
  func delete(set: IndexSet) {
    let filteredtodoList = self.todoService.read(by: status)
    
    guard let index = set.first else { return }
    
    let id = filteredtodoList[index].id
    
    todoService.delete(id: id)
    
    todoList = todoService.read(by: status)
  }
  
  func cellButtonTapped() {
    isShowEditView = true
  }
  
  func cellButtonLongPressed() {
    isLongPressing.toggle()
  }
  
  func closeButtonTapped() {
    isShowEditView = false
    isLongPressing = false
    
    todoList = todoService.read(by: status)
  }
}
