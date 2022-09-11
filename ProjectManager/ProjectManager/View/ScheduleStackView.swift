//
//  ScheduleStackView.swift
//  ProjectManager
//
//  Created by dhoney96 on 2022/09/11.
//

import UIKit

class ScheduleStackView: UIStackView {
    let toDoListView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderHeight = 50
        return tableView
    }()
    
    let doingListView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderHeight = 50
        return tableView
    }()
    
    let doneListView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderHeight = 50
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDefaultSetting()
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDefaultSetting() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray4
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 10
    }
    
    private func configureView() {
        self.addArrangedSubview(toDoListView)
        self.addArrangedSubview(doingListView)
        self.addArrangedSubview(doneListView)
    }
}
