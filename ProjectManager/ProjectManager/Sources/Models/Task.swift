//
//  Task.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import Foundation

final class Task: NSObject, Codable {

    enum State: String, Codable {
        case todo, doing, done
    }

    private(set) var id: UUID = UUID()
    var title: String
    var body: String
    var dueDate: Date
    var state: State
    var isExpired: Bool? {
        guard let currentDate = Date().date else { return nil }
        return dueDate < currentDate
    }

    init(title: String, body: String, dueDate: Date, state: State = .todo) {
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.state = state
    }
}
