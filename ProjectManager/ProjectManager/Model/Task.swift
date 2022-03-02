//
//  Task.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/02.
//

import Foundation

struct Task {
    
    private let id: String
    private var title: String
    private var body: String
    private var dueDate: TimeInterval
    private var status: TaskStatus
    
    init(title: String, body: String, dueDate: Date) {
        self.id = UUID().uuidString
        self.title = title
        self.body = body
        self.dueDate = dueDate.timeIntervalSince1970
        self.status = .todo
    }
}
