//
//  Task.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/07/31.
//

import Foundation

final class Task {
    let title: String
    let context: String
    let deadline: Date
    let classification: Classification

    init(title: String, context: String, deadline: Date, classification: Classification) {
        self.title = title
        self.context = context
        self.deadline = deadline
        self.classification = classification
    }
}
