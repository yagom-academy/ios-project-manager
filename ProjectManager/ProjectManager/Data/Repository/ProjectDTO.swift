//
//  ProjectDTO.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/19.
//

import Foundation

struct ProjectDTO: Codable {
    let id: String
    let status: String
    let title: String
    let deadline: String
    let body: String
}
