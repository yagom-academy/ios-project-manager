//
//  Plan.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import Foundation

struct Plan {
    let id: UUID = UUID()
    var title: String
    var body: String
    var date: Date
    var state: State
}
