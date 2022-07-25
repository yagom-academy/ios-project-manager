//
//  TaskType.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import RealmSwift

enum TaskType: String, PersistableEnum, Codable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
}
