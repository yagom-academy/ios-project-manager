//
//  Todo.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

struct Todo: Identifiable {
    let id: UUID = UUID()
    var title: String = ""
    var detail: String = ""
    var endDate: Date = Date()
    var state: TodoList.State = .todo
}
