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
  case create(Card)
  case update(Card)
  case delete(Card)
  case move(Card, CardType)
  
  var description: String {
    switch self {
    case let .create(title):
      return "Created: '\(title)'"
    case let .update(card):
      return "Updated: '\(card.title)' from \(card.cardType.description)"
    case let .delete(card):
      return "Deleted: '\(card.title)' from \(card.cardType.description)"
    case let .move(card, to):
      return "Moved: '\(card.title)' from \(card.cardType.description) to \(to.description)"
    }
  }
}
