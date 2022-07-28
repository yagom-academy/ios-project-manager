//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by song on 2022/07/28.
//

import Foundation

class HistoryViewModel: ObservableObject {
  let todoService: TodoService
  
  init(todoService: TodoService) {
    self.todoService = todoService
    print(todoService.historyStore.count)
  }
}
