//
//  Task.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import Foundation

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title, description: String
    var dueDate: Date
    var status: Status
}
