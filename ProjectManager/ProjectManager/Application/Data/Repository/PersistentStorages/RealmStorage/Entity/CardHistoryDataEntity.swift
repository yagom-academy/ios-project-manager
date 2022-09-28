//
//  CardHistoryDataEntity.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/26.
//

import Foundation
import RealmSwift

class CardHistoryDataEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var cardTypeDescription: String = ""
    @objc dynamic var cardState: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension CardHistoryDataEntity {
    convenience init(id: String,
                     title: String,
                     date: Date,
                     cardTypeDescription: String,
                     cardState: String) {
        self.init()

        self.id = id
        self.title = title
        self.date = date
        self.cardTypeDescription = cardTypeDescription
        self.cardState = cardState
    }

    func generate() -> CardHistoryModel {
        let cardState = CardState(rawValue: cardState) ?? .added
        let model = CardHistoryModel(id: id,
                                     title: title,
                                     date: date,
                                     cardTypeDescription: cardTypeDescription,
                                     cardState: cardState)
        return model
    }
}
