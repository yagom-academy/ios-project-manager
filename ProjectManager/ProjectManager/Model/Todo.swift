//
//  Todo.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

struct Todo: Hashable {
    let title: String
    let detail: String
    let endDate: Double
    let completionState: Int
}
