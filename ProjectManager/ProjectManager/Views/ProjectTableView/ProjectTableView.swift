//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/13.
//

import UIKit

final class ProjectTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        register(ProjectTableViewCell.self,
                 forCellReuseIdentifier: ProjectTableViewCell.reuseIdentifier)
        register(ProjectTableViewHeaderView.self,
                 forHeaderFooterViewReuseIdentifier: ProjectTableViewHeaderView.reuseIdentifier)

        backgroundColor = .systemGray6
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
