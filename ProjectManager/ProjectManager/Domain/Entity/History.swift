//
//  History.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/21.
//

import Foundation

struct History {
  let card: Card
  let actionType: HistoryActionType
  let actionTime: Date
}

enum HistoryActionType: CustomStringConvertible {
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
