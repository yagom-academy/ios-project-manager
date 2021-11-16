//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import Foundation

struct Project: Identifiable {
    var id: UUID
    var title: String
    var content: String
    var dueDate: Date
    var created: Date
    var status: Status
    
    enum Status: String, CaseIterable {
        case todo
        case doing
        case done
        
        var header: String {
            return self.rawValue.uppercased()
        }
        
        var theOthers: [Self] {
            return Self.allCases.filter { self.rawValue != $0.rawValue }
        }
    }
    
    mutating func update(_ newStatus: Status) {
        self.status = newStatus
    }
    
    init(id: UUID = UUID(), title: String, content: String, dueDate: Date, created: Date = Date(), status: Status = .todo) {
        self.id = id
        self.title = title
        self.content = content
        self.dueDate = dueDate
        self.created = created
        self.status = status
    }
}

extension Project {
    init() {
        self.id = UUID()
        self.title = ""
        self.content = ""
        self.dueDate = Date()
        self.created = Date()
        self.status = .todo
    }
}
