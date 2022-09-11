//
//  Todo.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation

struct Todo {
    let id: UUID = .init()
    let title, body: String
    let createdAt: Date
    let status: Status
}
