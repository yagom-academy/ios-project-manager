//
//  TaskTableView.swift
//  ProjectManager
//
//  Created by steven on 7/26/21.
//

import UIKit

class TaskTableView: UITableView {
    let type: String
    
    init(type: String) {
        self.type = type
        super.init(frame: .zero, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray6
        self.tableFooterView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
