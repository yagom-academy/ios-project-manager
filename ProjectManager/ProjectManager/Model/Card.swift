//
//  Card.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/04.
//

import Foundation

enum CardType {
  case todo
  case doing
  case done
}

struct Card {
  let id = UUID().uuidString
  var title: String
  var description: String
  var deadlineDate: Date
  var cardType: CardType = .todo
}
