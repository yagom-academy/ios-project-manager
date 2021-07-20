//
//  Task.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import Foundation

struct Task: Codable {
    let title: String
    let description: String
    let date: Double
    let status: String
}

let dummy = Task(title: "dummy title", description: "dummy description", date: 123, status: "todo")
