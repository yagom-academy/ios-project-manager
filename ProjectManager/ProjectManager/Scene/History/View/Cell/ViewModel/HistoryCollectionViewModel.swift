//
//  HistoryCollectionViewCell.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/29.
//

import Foundation

struct HistoryCollectionViewModel {
  func makeTitle(_ memento: Memento) -> String {
    return memento.historyState.rawValue + "'\(memento.todo.title)' from" + makeMovementDescription(
      fromState: memento.todo.state,
      toState: memento.toState
    )
  }
  
  func makeMovementDescription(fromState: State, toState: State?) -> String {
    if fromState == .todo, toState == .doing {
      return "TODO to DOING."
    }
    
    if fromState == .todo, toState == .done {
      return "TODO to DONE."
    }
    
    if fromState == .doing, toState == .todo {
      return "DOING to TODO."
    }
    
    if fromState == .doing, toState == .done {
      return "DOING to DONE."
    }
    
    if fromState == .done, toState == .todo {
      return "DONE to TODO."
    }
    
    return "DONE to DOING."
  }
}
