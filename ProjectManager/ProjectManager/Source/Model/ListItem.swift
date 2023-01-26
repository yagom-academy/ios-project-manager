//
//  ListItem.swift
//  ProjectManager
//  Created by inho on 2023/01/15.
//

import Foundation

struct ListItem: Hashable {
    var title: String
    var body: String
    var dueDate: Date
    let id = UUID()
}
