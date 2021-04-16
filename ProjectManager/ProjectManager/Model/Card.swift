//
//  Card.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/05.
//

import Foundation

struct Card: Codable {
    enum Status: Int, CaseIterable, Codable {
        case todo = 0
        case doing
        case done
        
        var index: Int {
            return self.rawValue
        }
        var tag: Int {
            return self.rawValue
        }
    }
    
    var id: Int?
    var title: String
    var descriptions: String?
    var deadline: Int?
    var status: Status
    
    var deadlineDate: Date? {
        if let deadline = deadline {
            return Date(timeIntervalSince1970: Double(deadline))
        } else {
            return nil
        }
    }
    
    mutating func update(card: Card) {
        title = card.title
        descriptions = card.descriptions
        deadline = card.deadline
        status = card.status
    }
}
