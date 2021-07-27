//
//  TaskList.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/21.
//

struct TaskList: Codable {

    typealias Count = (todo: Int, doing: Int, done: Int)

    private(set) var todos: [Task] = []
    private(set) var doings: [Task] = []
    private(set) var dones: [Task] = []

    subscript(state: Task.State) -> [Task] {
        get {
            switch state {
            case .todo:
                return self.todos
            case .doing:
                return self.doings
            case .done:
                return self.dones
            }
        }

        set {
            switch state {
            case .todo:
                todos = newValue
            case .doing:
                doings = newValue
            case .done:
                dones = newValue
            }
        }
    }
}
