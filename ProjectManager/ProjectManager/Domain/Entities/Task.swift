//
//  Task.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

struct Task {
    var title: String?
    var description: String?
    var expireDate: Date?
    var tag: Status?
}

enum Status {
    case todo
    case doing
    case done
}
