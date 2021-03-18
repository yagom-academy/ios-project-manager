//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation

struct Thing: Codable {
    let id: Int?
    let title: String
    let description: String?
    let dateNumber: Double
    var state: String?
    var isDone: Bool = false
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
    
    enum State: String {
        case todo = "todo"
        case doing = "doing"
        case done = "done"
    }
    
    var parameters: [String : Any] {[
        "id": id ?? 0,
        "title": title,
        "description": description ?? String.empty,
        "due_date": dateNumber,
        "state": state ?? "todo"
    ]}
}
