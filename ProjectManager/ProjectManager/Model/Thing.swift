//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation

struct Thing: Codable {
    let title: String
    let description: String
    let dateNumber: Int
    var isDone: Bool = false
    var dateString: String {
        return DateFormatter.convertToUserLocaleString(date: date)
    }
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateNumber))
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description
        case dateNumber = "due_date"
    }
}
