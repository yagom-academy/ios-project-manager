//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/13.
//

import UIKit

final class ProjectTableView: UITableView {
    private var headerTitle: String

    init(headerTitle: String, frame: CGRect, style: UITableView.Style) {
        self.headerTitle = headerTitle
        super.init(frame: frame, style: style)

        register(ProjectTableViewCell.self,
                 forCellReuseIdentifier: ProjectTableViewCell.reuseIdentifier)
        register(ProjectTableViewHeaderView.self,
                 forHeaderFooterViewReuseIdentifier: ProjectTableViewHeaderView.reuseIdentifier)

        backgroundColor = .systemGray6
    }

    convenience init(headerTitle: String) {
        self.init(headerTitle: headerTitle, frame: CGRect.zero, style: .plain)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
