//
//  Task.swift
//  ProjectManager
//
//  Created by steven on 7/22/21.
//

import Foundation
import MobileCoreServices

final class Task: NSObject, Codable {
    var title: String
    var content: String
    var deadLine: String
    var state: State
    
    init(title: String, content: String, deadLine: String, state: State) {
        self.title = title
        self.content = content
        self.deadLine = deadLine
        self.state = state
    }
}
