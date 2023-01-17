//
//  ProjectListViewController+DataSource.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/18.
//

import UIKit

extension ProjectListViewController {
    func configureProjectTableViewDelegate() {
        projectListView.todoTableView.delegate = self
        projectListView.doingTableView.delegate = self
        projectListView.doneTableView.delegate = self
    }

    func makeDataSource(tableView: UITableView) -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, project in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseIdentifier) as?
                    ProjectTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(with: project)

            return cell
        }

        return dataSource
    }

    func configureDataSource() {
        todoDataSource = makeDataSource(tableView: projectListView.todoTableView)
        doingDataSource = makeDataSource(tableView: projectListView.doingTableView)
        doneDataSource = makeDataSource(tableView: projectListView.doneTableView)
    }

    func configureSnapshot(dataSource: DataSource, items: [Project]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)

        if #available(iOS 15.0, *) {
            dataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    func configureSnapshots() {
        guard let todoDataSource,
              let doingDataSource,
              let doneDataSource else {
            fatalError("데이터소스 없음")
        }

        configureSnapshot(dataSource: todoDataSource, items: todoList)
        configureSnapshot(dataSource: doingDataSource, items: doingList)
        configureSnapshot(dataSource: doneDataSource, items: doneList)
    }
}
