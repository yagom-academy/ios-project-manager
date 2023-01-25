//
//  DataSourceViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import UIKit

struct DataSourceViewModel {
    func configureSnapShot(dataSource: UITableViewDiffableDataSource<Section, Task>, tasks: [Task]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapShot.appendSections([.main])
        snapShot.appendItems(tasks)
        dataSource.apply(snapShot)
    }
    
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "tableViewCell")
    }
}
