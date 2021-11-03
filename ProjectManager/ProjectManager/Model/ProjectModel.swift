//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/02.
//

import Foundation

struct ProjectModel: Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let description: String
    let date: Date
}
