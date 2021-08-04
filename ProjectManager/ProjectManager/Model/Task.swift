//
//  Task.swift
//  ProjectManager
//
//  Created by steven on 7/22/21.
//

import Foundation

final class Task: Codable {
    var id: String?
    var title: String
    var content: String
    var deadLine: TimeInterval
    var type: TaskType
    
    init(id: String? = nil, title: String, content: String, deadLine: TimeInterval, type: TaskType) {
        self.id = id
        self.title = title
        self.content = content
        self.deadLine = deadLine
        self.type = type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeIfPresent(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.deadLine = try container.decode(Double.self, forKey: .deadLine)
        self.type = try container.decode(TaskType.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.content, forKey: .content)
        try container.encode(self.deadLine, forKey: .deadLine)
        try container.encode(self.type, forKey: .type)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case content = "description"
        case deadLine = "dueDate"
        case type = "status"
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.content == rhs.content &&
            lhs.deadLine == rhs.deadLine &&
            lhs.type == rhs.type
    }
}
