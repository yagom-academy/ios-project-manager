//
//  KanBanTableView.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import UIKit

final class KanBanTableView: UITableView {
    private(set) var status: TaskStatus = .TODO

    var tasks: [Task] {
            switch status {
            case .TODO:
                return TaskManager.shared.toDoTasks
            case .DOING:
                return TaskManager.shared.doingTasks
            case .DONE:
                return TaskManager.shared.doneTasks
            }
    }

    init(status: TaskStatus) {
        self.status = status
        super.init(frame: .zero, style: .grouped)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
