//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by song on 2022/07/28.
//

import Foundation

class HistoryViewModel: ObservableObject {
  let todoService: TodoService
  @Published var historyLog: [HistoryModel] = []
  
  init(todoService: TodoService) {
    self.todoService = todoService
    historyLog = todoService.historyStore
    print(todoService.historyStore.count)
  }
}
