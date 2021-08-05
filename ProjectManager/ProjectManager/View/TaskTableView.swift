//
//  TaskTableView.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/08/03.
//

import UIKit

final class TaskTableView: UITableView {
    private var tasks: [Task] = []

    init() {
        super.init(frame: .zero, style: .grouped)

        self.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        self.contentInset.top = -27 // swift 버그로 tableView의 top spacing을 수정
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func createTask(task: Task) {
        tasks.insert(task, at: 0)
    }

    func readTask(index: Int) -> Task {
        return tasks[index]
    }

    func updateTask(index: Int, task: Task) {
        tasks[index] = task
    }

    func deleteTask(index: Int) {
        tasks.remove(at: index)
    }

    func countTasks() -> Int {
        return tasks.count
    }
}
