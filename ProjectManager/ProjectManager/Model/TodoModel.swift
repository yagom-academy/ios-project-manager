//
//  TodoModel.swift
//  ProjectManager
//
//  Created by Mangdi on 2023/01/14.
//

import Foundation

struct TodoModel: Identifiable {
    let id: UUID = UUID()
    var title, body, date: String
}
