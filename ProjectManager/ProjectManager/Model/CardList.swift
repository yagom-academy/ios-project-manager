//
//  CardList.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/06.
//

import Foundation

struct CardList: Decodable {
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case cards = "items"
    }
}
