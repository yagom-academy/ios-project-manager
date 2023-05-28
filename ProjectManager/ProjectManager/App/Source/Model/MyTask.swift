//
//  MyTask.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation

struct MyTask: Hashable {
    let id = UUID()
    var state: TaskState
    var title: String
    var body: String
    var deadline: Date
}
