//
//  HistoryCollectionViewCell.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/29.
//

import Foundation

struct HistoryCollectionViewModel {
  func makeTitle(_ memento: Memento) -> String {
    return memento.historyState.rawValue + " '\(memento.todo.title)' " + makeTitle(from: memento)
  }
  
  private func makeMovementDescription(from memento: Memento?) -> String {
    if memento?.todo.state == .todo, memento?.toState == .doing {
      return "from TODO to DOING."
    }
    
    if memento?.todo.state == .todo, memento?.toState == .done {
      return "from TODO to DONE."
    }
    
    if memento?.todo.state == .doing, memento?.toState == .todo {
      return "from DOING to TODO."
    }
    
    if memento?.todo.state == .doing, memento?.toState == .done {
      return "from DOING to DONE."
    }
    
    if memento?.todo.state == .done, memento?.toState == .todo {
      return "from DONE to TODO."
    }
    
    return "from DONE to DOING."
  }
  
  private func makeRemovedDescription(from memento: Memento?) -> String {
    if memento?.historyState == .removed, memento?.todo.state == .todo {
      return "from TODO"
    }
    
    if memento?.historyState == .removed, memento?.todo.state == .doing {
      return "from DOING"
    }
    
    return "from DONE"
  }
  
  private func makeTitle(from memento: Memento?) -> String {
    if memento?.historyState == .moved {
      return makeMovementDescription(from: memento)
    }
    
    if memento?.historyState == .removed {
      return makeRemovedDescription(from: memento)
    }
    
    return ""
  }
}
