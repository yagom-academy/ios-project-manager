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
            cell.gestureRecognizerHelperDelegate = self
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

extension DataSourceViewModel: GestureRecognizerHelperDelegate {
    func sendLongPressGesture(gesture: UIGestureRecognizer) {
        print("AA 일단 데이터소스뷰모델에서 호출")
    }
}

/*
 1. 분기처리를 팝오버매니저가함
 2. 팝오버뷰컨트롤러: tasmListVM을 소유함.
 3. 팝오버매니저: Yes No에 대한 분기처리에 대한 행동만 도와줌 (데이터소스뷰모델이 얘를 소유함.)
 */
