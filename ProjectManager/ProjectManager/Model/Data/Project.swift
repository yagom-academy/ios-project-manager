//
//  Project.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

enum ProjectKey: String {
    
    case identifier, title, description, deadline, status
}

struct Project {
    
    // MARK: - Property
    let identifier: String?
    private (set) var title: String?
    private (set) var deadline: Date?
    private (set) var description: String?
    private (set) var status: Status?
    
    var isExpired: Bool {
        let currentDate = Date()
        guard let deadline = self.deadline else {
           return false
        }
        return deadline < currentDate
    }
    
    // MARK: - Method
    mutating func updateContent(with input: [String: Any]) {
        self.title = input["title"] as? String
        self.deadline = input["deadline"] as? Date
        self.description = input["description"] as? String
    }
    
    mutating func updateStatus(with status: Status) {
        self.status = status
    }
}

// MARK: - Hashable
extension Project: Hashable {
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: - Codable
extension Project: Codable {
    
    enum CodingKeys: String, CodingKey {
        case identifier, title, description, deadline, status
    }
}
