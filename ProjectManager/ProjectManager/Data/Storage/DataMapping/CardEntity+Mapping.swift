//
//  CardEntity+Mapping.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import Foundation

extension CardEntity {
  func toDomain() -> Card {
    return Card(
      id: id ?? UUID().uuidString,
      title: title ?? "",
      description: body ?? "",
      deadlineDate: deadlineDate ?? Date(),
      cardType: CardType(rawValue: cardType) ?? .todo
    )
  }
}
