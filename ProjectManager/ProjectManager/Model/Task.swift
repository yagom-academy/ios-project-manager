//
//  Task.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

import Foundation

struct Task: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var deadline: String
    var listKind: ListKind = .todo
}
