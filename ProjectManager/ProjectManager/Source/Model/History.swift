//  ProjectManager - History.swift
//  created by zhilly on 2023/01/27

import Foundation

struct History: Hashable {
    let id: UUID
    let title: String
    let createdAt: String
    
    init(id: UUID = UUID(), title: String, createdAt: String) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
}
