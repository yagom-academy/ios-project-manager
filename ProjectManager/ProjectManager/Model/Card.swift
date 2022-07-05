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

#if DEBUG
extension Card {
  static let day: TimeInterval = 60 * 60 * 24
  static let sample = [
    Card(title: "할일1", description: "할일 설명", deadlineDate: Date().advanced(by: day), cardType: .todo),
    Card(title: "할일2", description: "할일 설명", deadlineDate: Date().advanced(by: -day), cardType: .done),
    Card(title: "할일3", description: "할일 설명", deadlineDate: Date().advanced(by: day), cardType: .done),
    Card(title: "할일4", description: "할일 설명", deadlineDate: Date(), cardType: .todo),
    Card(title: "할일5", description: "할일 설명", deadlineDate: Date().advanced(by: -day), cardType: .doing),
    Card(title: "할일6", description: "할일 설명", deadlineDate: Date(), cardType: .todo),
    Card(title: "할일7", description: "할일 설명", deadlineDate: Date().advanced(by: -day), cardType: .doing),
    Card(title: "할일8", description: "할일 설명", deadlineDate: Date().advanced(by: day), cardType: .done),
    Card(title: "할일9", description: "할일 설명", deadlineDate: Date().advanced(by: -day), cardType: .todo),
  ]
}
#endif
