//
//  Card.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/05.
//

import Foundation

struct Card: Codable {
    var id: Int?
    var title: String
    var descriptions: String?
    var deadline: Int?
    var status: Int?
    
    var deadlineDate: Date? {
        if let deadline = deadline {
            return Date(timeIntervalSince1970: Double(deadline))
        } else {
            return nil
        }
    }
}
