//
//  Todo.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

struct Todo: Hashable {
    var title: String
    var detail: String
    var endDate: Double
    var completionState: Int
}
