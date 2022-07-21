//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/15.
//

import Foundation
import Combine

final class EditViewModel: NSObject {
  private let storage: StorageType
  
  // MARK: - Output
  let item: Todo
  
  init(storage: StorageType = FireBaseService.shared, item: Todo) {
    self.storage = storage
    self.item = item
  }
  
  // MARK: - Input
  func doneButtonDidTap(title: String?, content: String?, date: Date?) {
    guard let title = title, let content = content, let date = date else {
      return
    }

    let todo = Todo(id: item.id, title: title, content: content, date: date, state: item.state)
    
    storage.update(todo)
  }
}
