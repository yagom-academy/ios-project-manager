//
//  ProjectDTO.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/19.
//

import Foundation

struct ProjectDTO {
    let id: UUID
    let status: String
    let title: String
    let deadline: Date
    let body: String
}
