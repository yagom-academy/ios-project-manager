//
//  Todo.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation

struct Todo: Equatable {
    let id: UUID = .init()
    var title, body: String
    let createdAt: Date = .init()
    var status: Status
    
    static func == (lhs: Todo, rhs: Todo) -> Bool {
        return lhs.id == rhs.id
    }
}
