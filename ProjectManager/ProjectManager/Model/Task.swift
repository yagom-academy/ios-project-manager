//
//  Task.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation

struct Task: Hashable {
    let id = UUID()
    let state: State
    let title: String
    let body: String
    let deadline: Date
}
