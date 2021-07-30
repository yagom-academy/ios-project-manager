//
//  Task.swift
//  ProjectManager
//
//  Created by steven on 7/22/21.
//

import Foundation

final class Task: Codable {
    var id: String
    var title: String
    var content: String
    var deadLine: TimeInterval
    var type: TaskType
    
    init(id: String, title: String, content: String, deadLine: TimeInterval, type: TaskType) {
        self.id = id
        self.title = title
        self.content = content
        self.deadLine = deadLine
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case content = "description"
        case deadLine = "dueDate"
        case type = "status"
    }
}
