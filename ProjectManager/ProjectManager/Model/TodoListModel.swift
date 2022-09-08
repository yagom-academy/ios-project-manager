//
//  TodoListModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import Foundation

struct TodoListModel: Hashable {
    let id = UUID().uuidString
    let title: String
    let description: String
    let deadlineDate: Date
}
