//
//  TodoEntity+Firebase.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/22.
//

import Foundation

struct TodoFirebaseEntity {
    private let title: String
    private let deadlineAt: TimeInterval
    private let body: String
    private let id: String
    private let state: String
    
    init(value: [String: Any]) {
        self.title = value["title"] as? String ?? ""
        self.deadlineAt = value["deadlineAt"] as? TimeInterval ?? Date().timeIntervalSince1970
        self.body = value["body"] as? String ?? ""
        self.id = value["id"] as? String ?? UUID().uuidString
        self.state = value["state"] as? String ?? State.todo.rawValue
    }
    
    func toTodoModel() -> TodoModel {
        return TodoModel(title: title,
                         body: body,
                         deadlineAt: Date(timeIntervalSince1970: deadlineAt),
                         state: State(rawValue: state) ?? State.todo,
                         id: UUID(uuidString: id) ?? UUID())
    }
}
