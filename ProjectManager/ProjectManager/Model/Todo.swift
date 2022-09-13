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

// MARK: - Sample Data (for Test)

extension Todo {
    static func generateSampleData(count: Int, maxBodyLine: Int, startDate: String, endData: String) -> [Todo] {
        var initialTodoList: [Todo] = []
        var randomStringList: [String] = []
        
        for index in (0..<maxBodyLine) {
            guard !randomStringList.isEmpty else {
                randomStringList.append("\(index)번째 줄")
                continue
            }
            
            let mergedString = randomStringList[index - 1] + "\n\(index)번째 줄"
            randomStringList.append(mergedString)
        }
        
        for index in (0..<count) {
            guard let randomStatus = TodoStatus(rawValue: Int.random(in: 0...2)),
                  let randomString = randomStringList.randomElement() else { break }
            let randomDate = Date.randomBetween(start: "2022-09-01", end: "2022-09-30")
            
            let todo = Todo(todoId: UUID(), title: "\(index)번째 할 일", body: "\(index)번째 : " + randomString, createdAt: randomDate, status: randomStatus, isOutdated: false)
            
            initialTodoList.append(todo)
        }
        
        return initialTodoList
    }
}
