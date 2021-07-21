//
//  TaskOrder.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/21.
//

import Foundation

struct TaskOrder: Codable {

    var todo: [UUID] = []
    var doing: [UUID] = []
    var done: [UUID] = []

    subscript(state: Task.State) -> [UUID] {
        switch state {
        case .todo:
            return self.todo
        case .doing:
            return self.doing
        case .done:
            return self.done
        }
    }
}
