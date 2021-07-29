//
//  TaskTableView.swift
//  ProjectManager
//
//  Created by steven on 7/26/21.
//

import UIKit

class TaskTableView: UITableView {
    let state: TaskType
    
    init(state: TaskType) {
        self.state = state
        super.init(frame: .zero, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray6
        self.tableFooterView = UIView()
    }
    
    required init?(coder: NSCoder) {
        self.state = .todo
        super.init(coder: coder)
    }
    
}
