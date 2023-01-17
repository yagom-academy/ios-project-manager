//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/13.
//

import UIKit

final class ProjectTableView: UITableView {
    var headerTitle: String

    override init(frame: CGRect, style: UITableView.Style) {
        self.headerTitle = ""
        super.init(frame: frame, style: style)

        register(ProjectTableViewCell.self,
                 forCellReuseIdentifier: ProjectTableViewCell.reuseIdentifier)
        register(ProjectTableViewHeaderView.self,
                 forHeaderFooterViewReuseIdentifier: ProjectTableViewHeaderView.reuseIdentifier)
    }

    convenience init(headerTitle: String) {
        self.init(frame: CGRect.zero, style: .plain)
        self.headerTitle = headerTitle
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
