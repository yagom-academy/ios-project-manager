//
//  CardLocalDataEntity.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/22.
//

import Foundation
import RealmSwift

class CardLocalDataEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var listTitle: String = ""
    @objc dynamic var listDescription: String = ""
    @objc dynamic var listDeadlineDate: Date = Date()
    @objc dynamic var listCardType: String = "TODO"

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension CardLocalDataEntity {
    convenience init(id: String,
                     title: String,
                     description: String,
                     deadlineDate: Date,
                     cardType: CardType) {
        self.init()

        self.id = id
        self.listTitle = title
        self.listDescription = description
        self.listDeadlineDate = deadlineDate
        self.listCardType = cardType.rawValue
    }

    func generate() -> CardModel {
        let model = CardModel(id: id,
                              title: listTitle,
                              description: listDescription,
                              deadlineDate: listDeadlineDate,
                              cardType: CardType(rawValue: listCardType) ?? .todo)

        return model
    }

    func update(_ entity: CardModel) {
        self.listTitle = entity.title
        self.listDescription = entity.description
        self.listDeadlineDate = entity.deadlineDate
        self.listCardType = entity.cardType.rawValue
    }
}
