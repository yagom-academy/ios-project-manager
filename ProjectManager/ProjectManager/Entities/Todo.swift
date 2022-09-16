//
//  Todo.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import FirebaseFirestore

struct Todo: Codable {
    var todoId: UUID
    var title: String
    var body: String
    var createdAt: Date
    var status: TodoStatus
    var isOutdated: Bool
    
    enum CodingKeys: String, CodingKey {
        case todoId = "todo_id"
        case title
        case body
        case createdAt = "created_at"
        case status
        case isOutdated = "is_outdated"
    }
    
    init(todoId: UUID, title: String, body: String, createdAt: Date, status: TodoStatus, isOutdated: Bool) {
        self.todoId = todoId
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.status = status
        self.isOutdated = isOutdated
    }
    
    init?(dictionary: [String: Any]) {
        guard let todoIdString = dictionary["todo_id"] as? String,
              let todoId = UUID(uuidString: todoIdString),
              let title = dictionary["title"] as? String,
              let body = dictionary["body"] as? String,
              let createdAt = dictionary["created_at"] as? Timestamp,
              let statusInt = dictionary["status"] as? Int,
              let status = TodoStatus(rawValue: statusInt),
              let isOutdated = dictionary["is_outdated"] as? Bool else { return nil }
        
        self.todoId = todoId
        self.title = title
        self.body = body
        self.createdAt = createdAt.dateValue()
        self.status = status
        self.isOutdated = isOutdated
    }
}
