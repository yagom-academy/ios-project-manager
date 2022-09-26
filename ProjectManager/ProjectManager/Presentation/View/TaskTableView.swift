//
//  TaskTableView.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import UIKit

class TaskTableView: UITableView, UITableViewDelegate {
    let projectState: TaskState?
    
    init(projectState: TaskState) {
        self.projectState = projectState
        super.init(frame: .zero, style: .plain)
        
        self.register(TaskHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProjectHeaderView")
        self.register(TaskListCell.self, forCellReuseIdentifier: "ProjectListCell")
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
