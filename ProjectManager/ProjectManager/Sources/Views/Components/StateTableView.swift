//
//  StateTableView.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/27.
//

import UIKit

final class StateTableView: UITableView {

    typealias PMDelegate = UITableViewDataSource & UITableViewDelegate &
                           UITableViewDragDelegate & UITableViewDropDelegate

    // MARK: Properties

    private(set) var state: Task.State?

    // MARK: Initializers

    init(state: Task.State?) {
        super.init(frame: .zero, style: .plain)
        self.state = state
        register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Configures

    func setDelegates(_ pmDelegate: PMDelegate) {
        dataSource = pmDelegate
        delegate = pmDelegate
        dragDelegate = pmDelegate
        dropDelegate = pmDelegate
    }
}
