//
//  Project.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

struct Project {
    // MARK: - Property
    private var title: String?
    private var deadline: Date?
    private var description: String?
    private var status: Status
    
    var isExpired: Bool {
        let currentDate = Date()
        guard let deadline = self.deadline else {
           return false
        }
        return deadline < currentDate
    }
    
    // MARK: - Method
    func readTitle() -> String? {
        return self.title
    }
    
    func readDeadline() -> Date? {
        return self.deadline
    }
    
    func readDescription() -> String? {
        return self.description
    }
    
    func readStatus() -> Status {
        return self.status
    }
    
    mutating func updateContent(with input: [String: Any]) {
        self.title = input["title"] as? String
        self.deadline = input["deadline"] as? Date
        self.description = input["description"] as? String
    }
    
    mutating func updateStatus(with status: Status) {
        self.status = status
    }
}
