//
//  WriteViewModel.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/17.
//

import Foundation
import Combine

final class WriteViewModel {
  private let storage: StorageType
  private var originator: Originatable
  
  init(storage: StorageType = FireBaseService.shared, originator: Originatable = Originator.shared) {
    self.storage = storage
    self.originator = originator
  }
  
  // MARK: - Input
  func doneButtonDidTap(title: String?, content: String?, date: Date?) {
    guard let title = title, let content = content, let date = date else {
      return
    }

    let todo = Todo(title: title, content: content, date: date)
    
    storage.create(todo)
    saveHistory(todo)
  }
  
  private func saveHistory(_ todo: Todo) {
    originator.createMemento(Memento(todo: todo, historyState: .added))
  }
  
  // MARK: - Output
}
