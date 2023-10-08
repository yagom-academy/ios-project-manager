//
//  TaskDTO.swift
//  ProjectManager
//
//  Created by Hyungmin Lee on 2023/10/08.
//

import Foundation

struct TaskDTO: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let deadline: String
    let isPassDeadline: Bool
    let taskStatus: TaskStatus
}
