//
//  Todo.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

struct Todo: Equatable {

    var title: String
    var content: String
    var deadline: Double?
    var uuid: UUID
}
