//
//  TaskList.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/21.
//

struct TaskList: Codable {

    private var todos: [Task]
    private var doings: [Task]
    private var dones: [Task]

    init(todos: [Task] = [], doings: [Task] = [], dones: [Task] = []) {
        self.todos = todos
        self.doings = doings
        self.dones = dones
    }

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
