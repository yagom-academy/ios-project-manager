//
//  TodoModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/29.
//

import Foundation

struct TodoModel {
    var id: UUID = UUID()
    let category: String
    let title: String
    let body: String
    let date: Date
}
