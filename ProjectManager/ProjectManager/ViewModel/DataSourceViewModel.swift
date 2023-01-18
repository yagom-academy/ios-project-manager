//
//  DataSourceViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import UIKit

struct DataSourceViewModel {
    func makeDataSource(tableView: UITableView,
                        _ tasks: [Task]) -> UITableViewDiffableDataSource<Section, Task> {
        
        registerCell(tableView: tableView)
        
        let dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: tableView) { _, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell",
                                                     for: indexPath) as? TableViewCell ?? TableViewCell()
            cell.titleLabel.text = task.title
            cell.descriptionLabel.text = task.description
            cell.dateLabel.text = task.date?.description
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
