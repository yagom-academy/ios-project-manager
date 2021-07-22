//
//  Task.swift
//  ProjectManager
//
//  Created by 배은서 on 2021/07/22.
//

import Foundation

struct Task: Codable {
    let id: String?
    let title: String
    let content: String
    let deadLineDate: Date
    let classification: String
    var formattedDeadLineDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: self.deadLineDate)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, content, classification
        case deadLineDate = "deadline_date"
    }
}
