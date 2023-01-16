//
//  DataSourceViewModel.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import UIKit

struct DataSourceViewModel {
    func makeDataSource(tableView: UITableView, _ viewModel: TaskListViewModel) -> UITableViewDiffableDataSource<Section, Task> {
        registerCell(tableView: tableView)
        let dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: tableView) { _, indexPath, _ in
            let taskVM = viewModel.tasks[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell ?? TableViewCell()
            cell.titleLabel.text = taskVM.title
            cell.descriptionLabel.text = taskVM.description
            cell.dateLabel.text = taskVM.date?.description
            return cell
        }
        configureSnapShot(dataSource: dataSource, viewModel: viewModel)
        return dataSource
    }
    
    private func configureSnapShot(dataSource: UITableViewDiffableDataSource<Section, Task>, viewModel: TaskListViewModel) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapShot.appendSections([.main])
        snapShot.appendItems(viewModel.tasks)
        dataSource.apply(snapShot)
    }
    
    private func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
    }
    
}
