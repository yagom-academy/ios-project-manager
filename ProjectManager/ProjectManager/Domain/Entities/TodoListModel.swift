//
//  Model.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/06.
//

import Foundation

struct TodoListModel {
    let title: String
    let content: String
    let deadLine: Date
    var processType: ProcessType
}

enum ProcessType {
    case todo
    case doing
    case done
}
