//
//  ToDo.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import Foundation

struct Plan: Hashable {
    let id: UUID
    var title: String
    var description: String
    var deadline: Date
    var status: Status

    enum Status {
        case todo
        case doing
        case done
    }
}
