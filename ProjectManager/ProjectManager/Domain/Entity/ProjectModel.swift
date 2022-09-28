//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

import Foundation

struct ProjectModel: Codable {
    let id: String
    let title: String
    let body: String
    let date: Date
    let workState: ProjectState
}
