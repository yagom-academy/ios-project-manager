//
//  CardModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import Foundation

struct CardModel: Hashable {
    let id: String
    let title: String
    let description: String
    let deadlineDate: Date
    var cardType: CardType

    init(id: String,
         title: String,
         description: String,
         deadlineDate: Date,
         cardType: CardType) {
        self.id = id
        self.title = title
        self.description = description
        self.deadlineDate = deadlineDate
        self.cardType = cardType
    }
}
