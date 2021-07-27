//
//  StateTableView.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/27.
//

import UIKit

final class StateTableView: UITableView {

    // MARK: Properties

    var state: Task.State?

    // MARK: Initializers

    init(state: Task.State?) {
        self.state = state
        super.init(frame: .zero, style: .plain)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
