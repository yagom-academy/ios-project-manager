//
//  History.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/21.
//

import Foundation

struct History {
  var prev: Card? = nil
  var next: Card? = nil
  let actionType: HistoryActionType
  let actionTime: Date = Date()
}

enum HistoryActionType: Equatable, CustomStringConvertible {
  case create
  case update
  case delete
  case move(CardType)
  
  var description: String {
    switch self {
    case .create:
      return "CREATED"
    case .update:
      return "UPDATED"
    case .delete:
      return "DELETED"
    case .move(_):
      return "MOVED"
    }
  }
}
