//
//  ProjectItem.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import Foundation

struct ProjectItem {
    let id: UUID
    var status: String
    var title: String
    var deadline: Date
    var description: String
}
