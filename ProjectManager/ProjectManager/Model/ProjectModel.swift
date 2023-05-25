//
//  ToDoModel.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/17.
//

import Foundation

struct ProjectModel: Hashable {
    let id = UUID()
    var title: String
    var description: String
    var deadLine: Date
    var state: State
    var ispastdue: Bool {
        return deadLine < Date()
    }
}
