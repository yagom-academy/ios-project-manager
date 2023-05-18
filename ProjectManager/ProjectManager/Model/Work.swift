//
//  Work.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import Foundation

struct Work {
    let id: UUID
    var status: String = WorkStatus.todo
    var title: String
    var body: String
    var deadline: Date
}
