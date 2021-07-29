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

        self.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)

        self.contentInset.top = -30 // swift 버그로 인해 navigation controller에 들어가는 table view에 spacing 문제 때문에 해주는 작업
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
