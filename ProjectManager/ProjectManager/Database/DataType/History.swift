//
//  History.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/25.
//

import Foundation

struct History: Hashable {
    let title: String
    let date: Date
    let from: TaskType
    let to: TaskType?
    let changedType: WorkType
}
