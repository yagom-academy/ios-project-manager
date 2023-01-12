//
//  TaskItem.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import Foundation

struct Issue: Hashable {
    var status: Status
    var title: String
    var body: String
    var dueDate: Date
}
