//
//  ListItem.swift
//  ProjectManager
//  Created by inho on 2023/01/15.
//

import Foundation

struct ListItem: Hashable {
    let title: String
    let body: String
    let dueDate: String
    let id = UUID()
}
