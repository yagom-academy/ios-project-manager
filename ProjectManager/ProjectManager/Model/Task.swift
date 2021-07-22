//
//  Task.swift
//  ProjectManager
//
//  Created by steven on 7/22/21.
//

import Foundation

final class Task {
    var title: String
    var content: String
    var deadLine: String
    
    init(title: String, content: String, deadLine: String) {
        self.title = title
        self.content = content
        self.deadLine = deadLine
    }
}
