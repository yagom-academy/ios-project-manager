//
//  History.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/21.
//

import Foundation

struct History {
  let actionType: HistoryActionType
  let actionTime: Date
}

enum HistoryActionType: CustomStringConvertible {
  case create(String)
  case update(String, CardType)
  case delete(String, CardType)
  case move(String, CardType, CardType)
  
  var description: String {
    switch self {
    case let .create(title):
      return "Created: '\(title)'"
    case let .update(title, from):
      return "Updated: '\(title)' from \(from.description)"
    case let .delete(title, from):
      return "Deleted: '\(title)' from \(from.description)"
    case let .move(title, from, to):
      return "Moved: '\(title)' from \(from.description) to \(to.description)"
    }
  }
}
