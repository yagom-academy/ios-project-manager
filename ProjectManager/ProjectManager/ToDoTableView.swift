//
//  ToDoTableView.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import UIKit

class ToDoTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
