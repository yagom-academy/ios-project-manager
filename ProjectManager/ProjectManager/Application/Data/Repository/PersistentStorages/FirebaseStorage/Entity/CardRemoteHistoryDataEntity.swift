//
//  CardRemoteHistoryDataEntity.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/27.
//

import Foundation

struct CardRemoteHistoryDataEntity {
    private let id: String
    private let title: String
    private let date: Date
    private let cardTypeDescription: String
    private let cardState: String

    init(entity: [String: Any]) {
        self.id = entity["id"] as? String ?? ""
        self.title = entity["title"] as? String ?? ""
        self.cardTypeDescription = entity["cardTypeDescription"] as? String ?? ""
        self.date = entity["date"] as? Date ?? Date()
        self.cardState = entity["cardState"] as? String ?? ""
    }

    func generate() -> CardHistoryModel {
        return CardHistoryModel(id: id,
                                title: title,
                                date: date,
                                cardTypeDescription: cardTypeDescription,
                                cardState: CardState(rawValue: cardState) ?? .moved)
    }
}
