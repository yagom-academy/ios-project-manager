//
//  TodoListItem.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import Foundation

struct TodoListItem: Identifiable {
    var title: String
    var description: String
    var date: Date
    var id = UUID()
}

