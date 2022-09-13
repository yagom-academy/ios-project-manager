//
//  Project.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/13.
//

import Foundation

struct Project: Identifiable {
    let id: UUID
    var status: Status
    var title: String
    var detail: String
    var date: Date
}

enum Status: String, CaseIterable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
}
