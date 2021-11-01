//
//  Task.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/27.
//

import Foundation

struct Task: Identifiable {
    
    var title: String
    var description: String
    var date: Date
    var localizedDate: String {
        date.format()
    }
    let id = UUID()
    var state: TaskState
}
