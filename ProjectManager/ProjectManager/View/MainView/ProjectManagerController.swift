//
//  ProjectManager - ProjectManagerController.swift
//  Created by 수꿍, 휴 on 2022/09/07.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerController: UIViewController {
    enum Schedule {
        case todo
        case doing
        case done
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Schedule, ProjectUnit>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, ProjectUnit>
    
    private let scheduleStackView = ScheduleStackView()
    
    private var toDoViewdataSource: DataSource?
    private var toDoViewSnapshot: Snapshot?
    private var doingViewdataSource: DataSource?
    private var doingViewSnapshot: Snapshot?
    private var doneViewdataSource: DataSource?
    private var doneViewSnapshot: Snapshot?

    private let viewModel = ViewModel(databaseManager: MockLocalDatabaseManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureUI()
        configureToDoViewDataSource()
        configureDoingViewDataSource()
        configureDoneViewDataSource()
        configureObserver()
    }
    
    private func configureObserver() {
        viewModel.toDoData.subscribe { [weak self] projectUnitArray in
            guard let self = self else {
                return
            }

            self.toDoViewSnapshot = self.configureSnapshot(data: projectUnitArray, to: .todo)

            guard let toDoViewSnapshot = self.toDoViewSnapshot else {
                return
            }

            self.toDoViewdataSource?.apply(toDoViewSnapshot)
        }
        
        viewModel.doingData.subscribe { [weak self] projectUnitArray in
            guard let self = self else {
                return
            }

            self.doingViewSnapshot = self.configureSnapshot(data: projectUnitArray, to: .doing)

            guard let doingViewSnapshot = self.doingViewSnapshot else {
                return
            }

            self.doingViewdataSource?.apply(doingViewSnapshot)
        }
        
        viewModel.doneData.subscribe { [weak self] projectUnitArray in
            guard let self = self else {
                return
            }
            
            self.doneViewSnapshot = self.configureSnapshot(data: projectUnitArray, to: .done)

            guard let doneViewSnapshot = self.doneViewSnapshot else {
                return
            }

            self.doneViewdataSource?.apply(doneViewSnapshot)
        }
    }
    
    private func configureNavigationItems() {
        self.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    @objc func didTapAddButton() {
        let projectAdditionController = ProjectAdditionController()
        projectAdditionController.viewModel = self.viewModel

        let navigationController = UINavigationController(rootViewController: projectAdditionController)
        navigationController.modalPresentationStyle = .formSheet

        self.present(navigationController, animated: true)
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

        tableView.register(cellType: ProjectManagerListCell.self)
        
        tableView.delegate = self
        
        toDoViewdataSource = DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                let cell: ProjectManagerListCell = tableView.dequeueReusableCell(for: indexPath)
                cell.titleLabel.text = item.title
                cell.bodyLabel.text = item.body
                cell.dateLabel.text = item.deadLine.localizedString

                cell.separatorInset = .zero
                
                return cell
            }
        )
    }
    
    private func configureDoingViewDataSource() {
        let tableView = scheduleStackView.doingListView

        tableView.register(cellType: ProjectManagerListCell.self)
        
        tableView.delegate = self
        
        doingViewdataSource = DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                let cell: ProjectManagerListCell = tableView.dequeueReusableCell(for: indexPath)
                cell.titleLabel.text = item.title
                cell.bodyLabel.text = item.body
                cell.dateLabel.text = item.deadLine.localizedString

                cell.separatorInset = .zero
                
                return cell
            }
        )
    }
    
    private func configureDoneViewDataSource() {
        let tableView = scheduleStackView.doneListView

        tableView.register(cellType: ProjectManagerListCell.self)
        
        tableView.delegate = self
        
        doneViewdataSource = DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                let cell: ProjectManagerListCell = tableView.dequeueReusableCell(for: indexPath)
                cell.titleLabel.text = item.title
                cell.bodyLabel.text = item.body
                cell.dateLabel.text = item.deadLine.localizedString

                cell.separatorInset = .zero
                
                return cell
            }
        )
    }
    
    private func configureSnapshot(data: [ProjectUnit], to section: Schedule) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(data)

        return snapshot
    }
}

extension ProjectManagerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case scheduleStackView.toDoListView:
            let headerView = SectionHeaderView()
            headerView.setupLabelText(section: "TODO", number: 2)
            
            return headerView
        case scheduleStackView.doingListView:
            let headerView = SectionHeaderView()
            headerView.setupLabelText(section: "Doing", number: 0)
            
            return headerView
        case scheduleStackView.doneListView:
            let headerView = SectionHeaderView()
            headerView.setupLabelText(section: "Done", number: 0)
            
            return headerView
        default:
            return nil
        }
    }
}
