//
//  WriteViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/17.
//

import Foundation

final class WriteViewModel {
  private let storage: StorageType
  
  init(storage: StorageType = FireBaseService.shared) {
    self.storage = storage
  }
  
  // MARK: - Input
  func doneButtonDidTap(title: String?, content: String?, date: Date?) {
    guard let title = title, let content = content, let date = date else {
      return
    }

    let todo = Todo(title: title, content: content, date: date)
    
    storage.create(todo)
  }
  
  // MARK: - Output
}
