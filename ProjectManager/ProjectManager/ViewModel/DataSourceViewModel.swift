//
//  DataSourceViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import UIKit

struct DataSourceViewModel {
    func makeDataSource(tableView: UITableView, _
                        tasks: [Task]) -> UITableViewDiffableDataSource<Section, Task> {
        registerCell(tableView: tableView)
        
        let dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: tableView) { _, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell",
                                                     for: indexPath) as? TableViewCell ?? TableViewCell()

            let taskStatus = task.status
            switch taskStatus {
            case .todo:
                let todoTask = tasks[indexPath.row]
                cell.titleLabel.text = todoTask.title
                cell.descriptionLabel.text = todoTask.description
                cell.dateLabel.text = todoTask.date?.description
            case .doing:
                let doingTask = tasks[indexPath.row]
                cell.titleLabel.text = doingTask.title
                cell.descriptionLabel.text = doingTask.description
                cell.dateLabel.text = doingTask.date?.description
            case .done:
                let doneTask = tasks[indexPath.row]
                cell.titleLabel.text = doneTask.title
                cell.descriptionLabel.text = doneTask.description
                cell.dateLabel.text = doneTask.date?.description
            }
            return cell
        }
        configureSnapShot(dataSource: dataSource, tasks: tasks)
        return dataSource
    }
    
    private func configureSnapShot(dataSource: UITableViewDiffableDataSource<Section, Task>, tasks: [Task]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapShot.appendSections([.main])
        snapShot.appendItems(tasks)
        dataSource.apply(snapShot)
    }
    
    private func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
    }
}
