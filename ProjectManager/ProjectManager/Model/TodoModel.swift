//
//  TodoModel.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import Foundation

struct TodoModel: Hashable, Identifiable {
    let id: UUID = UUID()
    var title: String = ""
    var body: String = ""
    var status: TodoStatus = .todo
    var date: TimeInterval = 0.0
    
    enum TodoStatus {
        case todo
        case doing
        case done
    }
}
