//
//  CardRemoteDataEntity.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/24.
//

import Foundation

struct CardRemoteDataEntity {
    private let id: String
    private let title: String
    private let description: String
    private let deadlineDate: Date
    private let cardType: CardType

    init(entity: [String: Any]) {
        self.id = entity["id"] as? String ?? ""
        self.title = entity["title"] as? String ?? ""
        self.description = entity["description"] as? String ?? ""
        self.deadlineDate = entity["deadlineDate"] as? Date ?? Date()
        self.cardType = CardType(rawValue: entity["cardType"] as? String ?? "") ?? .todo
    }

    func generate() -> CardModel {
        return CardModel(id: id,
                         title: title,
                         description: description,
                         deadlineDate: deadlineDate,
                         cardType: cardType)
    }
}
