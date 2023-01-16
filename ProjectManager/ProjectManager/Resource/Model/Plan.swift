//
//  ToDo.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import Foundation

struct Plan: Hashable {
    enum Status {
        case todo
        case doing
        case done
    }

    var status: Status
    var title: String
    var description: String
    var deadline: Date
    let id: UUID
}
