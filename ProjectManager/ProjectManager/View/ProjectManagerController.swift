//
//  ProjectManager - ProjectManagerController.swift
//  Created by 수꿍, 휴 on 2022/09/07.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Schedule, ProjectUnit>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, ProjectUnit>
    
    private let scheduleStackView = ScheduleStackView()
    private var toDoViewdataSource: DataSource?
    private var toDoViewSnapshot: Snapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureUI()
        configureToDoViewDataSource()
        configureToDoViewSnapshot()
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
    
    private func configureToDoViewDataSource() {
        let tableView = scheduleStackView.toDoListView

        tableView.register(
            ProjectManagerListCell.self,
            forCellReuseIdentifier: ProjectManagerListCell.identifier
        )
        
        tableView.delegate = self
        
        toDoViewdataSource = DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, _ in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ProjectManagerListCell.identifier,
                    for: indexPath
                ) as? ProjectManagerListCell else {
                    return nil
                }
                
                cell.separatorInset = .zero
                
                return cell
            }
        )
    }
    
    private func configureToDoViewSnapshot() {
        toDoViewSnapshot = Snapshot()

        let unit = ProjectUnit(id: UUID(), title: "쥬스 메이커", body: "쥬스 메이커 프로젝트입니다", section: "ToDo", deadLine: Date())
        let unit2 = ProjectUnit(id: UUID(), title: "은행 창구 매니저", body: "은행 창구 매니저 프로젝트입니다", section: "Doing", deadLine: Date())

        toDoViewSnapshot?.appendSections([.todo])
        toDoViewSnapshot?.appendItems([unit, unit2])

        toDoViewdataSource?.apply(toDoViewSnapshot!)
    }
}

extension ProjectManagerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case scheduleStackView.toDoListView:
            let headerView = SectionHeaderView()
            headerView.setupLabelText(section: "TODO", number: 5)
            
            return headerView
        case scheduleStackView.doingListView:
            return UIView()
        case scheduleStackView.doneListView:
            return UIView()
        default:
            return UIView()
        }
    }
}

enum Schedule {
    case todo
    case doing
    case done
}
