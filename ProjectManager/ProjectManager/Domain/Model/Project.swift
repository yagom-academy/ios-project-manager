//
//  Project.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

struct Project: Hashable {

    var title: String
    var description: String
    var deadline: Date
    var state: State
    let identifier: UUID

    init(title: String = "",
         description: String = "",
         deadline: Date = Date(),
         state: State = .toDo,
         identifier: UUID = UUID()) {
        self.title = title
        self.description = description
        self.deadline = deadline
        self.state = state
        self.identifier = identifier
    }
}
