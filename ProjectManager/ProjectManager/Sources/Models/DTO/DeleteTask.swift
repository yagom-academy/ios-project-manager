//
//  DeleteTask.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import Foundation

struct DeleteTask: Encodable {

    private let id: UUID

    init(by task: Task) {
        id = task.id
    }
}
