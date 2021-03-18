//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation

struct Thing: Codable {
    let id: Int? = nil
    let title: String
    let description: String
    let dateNumber: Double
    var isDone: Bool = false
    var dateString: String {
        return DateFormatter.convertToUserLocaleString(date: date)
    }
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateNumber))
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description
        case dateNumber = "due_date"
    }
}
