//
//  CardHistoryModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/25.
//

import Foundation

struct CardHistoryModel: Hashable {
    let id: String
    let title: String
    let date: Date
    let cardTypeDescription: String
    let cardState: CardState

    init(id: String,
         title: String,
         date: Date,
         cardTypeDescription: String,
         cardState: CardState) {
        self.id = id
        self.title = title
        self.date = date
        self.cardTypeDescription = cardTypeDescription
        self.cardState = cardState
    }
}
