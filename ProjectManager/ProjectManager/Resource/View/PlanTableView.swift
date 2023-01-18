//
//  ToDoTableView.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import UIKit

final class PlanTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.register(PlanTableViewCell.self, forCellReuseIdentifier: PlanTableViewCell.reuseIdentifier)
        self.register(PlanListHeaderView.self, forHeaderFooterViewReuseIdentifier: PlanListHeaderView.reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
