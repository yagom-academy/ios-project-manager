//
//  KanBanTableView.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/20.
//

import UIKit

final class KanBanTableView: UITableView {
    private(set) var statusName: String = ""
    private(set) var tasks: [Task] = []

    init(statusName: String, tasks: [Task]) {
        self.statusName = statusName
        self.tasks = tasks
        super.init(frame: .zero, style: .grouped)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
