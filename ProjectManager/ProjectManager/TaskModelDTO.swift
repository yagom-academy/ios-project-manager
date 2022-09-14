//
//  TaskModelDTO.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

import Foundation

struct TaskModelDTO {
    let id: UUID
    let title: String
    let body: String
    let date: Date
    let state: ProjectState
}
