//
//  TodoView.swift
//  ProjectManager
//
//  Created by kimseongjun on 2023/05/18.
//

import UIKit
//protocol ViewMakeable: AnyObject {
//
//}
//
//extension ViewMakeable {
//    private func configureDataSource(schedule: Schedule) {
//
//        self.tableView.register(ScheduleCell.self, forCellReuseIdentifier: "cell")
//
//        self.dataSource = UITableViewDiffableDataSource<Section, Schedule> (tableView: self.tableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
//
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScheduleCell else { return nil }
//
//            cell.configureUI()
//            cell.configureLabel(schedule: schedule)
//
//            return cell
//
//        }
//    }
//}


class TodoView: DoListView {}

class DoingView: DoListView {}

class DoneView: DoListView {}

class DoListView: UIView {
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, Schedule>?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    func configureDataSource(schedule: Schedule) {
        
        self.tableView.register(ScheduleCell.self, forCellReuseIdentifier: "cell")

        self.dataSource = UITableViewDiffableDataSource<Section, Schedule> (tableView: self.tableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScheduleCell else { return nil }
            
            cell.configureUI()
            cell.configureLabel(schedule: schedule)
            
            return cell
        }
    }
    
    func applySnapshot(schedules: [Schedule]) {
            var  snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
            snapshot.appendSections([.main])
            snapshot.appendItems(schedules)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    
    func configureUI() {
        tableView.backgroundColor = .red
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
