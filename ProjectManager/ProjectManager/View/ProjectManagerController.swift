//
//  ProjectManager - ProjectManagerController.swift
//  Created by 수꿍, 휴 on 2022/09/07.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Schedule, ProjectUnit>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, ProjectUnit>
    
    private let scheduleStackView = ScheduleStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureUI()
        
    }
    
    private func configureNavigationItems() {
        self.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(scheduleStackView)
        
        NSLayoutConstraint.activate([
            scheduleStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scheduleStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scheduleStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scheduleStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProjectManagerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case scheduleStackView.toDoListView:
            return UIView()
        case scheduleStackView.doingListView:
            return UIView()
        case scheduleStackView.doneListView:
            return UIView()
        default:
            return UIView()
        }
    }
}

struct Schedule: Hashable {
    enum Todo {
        case main
    }
    
    enum Doing {
        case main
    }
    
    enum Done {
        case main
    }
}
