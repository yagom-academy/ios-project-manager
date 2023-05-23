//
//  Task.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation

struct Task: Hashable {
    let id = UUID()
    var state: State
    var title: String
    var body: String
    var deadline: Date
}
