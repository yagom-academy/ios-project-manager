//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation

struct Thing: Codable {
    let id: Int?
    var title: String
    var description: String?
    var dateNumber: Double
    var state: String?
    var dateString: String {
        return DateFormatter.convertToUserLocaleString(date: date)
    }
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateNumber))
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, state
        case dateNumber = "due_date"
    }
    
    var parameters: [String : Any] {[
        "id": id ?? 0,
        "title": title,
        "description": description ?? String.empty,
        "due_date": dateNumber,
        "state": state ?? "todo"
    ]}
}
