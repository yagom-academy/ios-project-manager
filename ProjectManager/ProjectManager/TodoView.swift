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


class TodoView: UIView {
    enum Section: CaseIterable {
        case todo
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, Schedule>?
    
    private let tableView = UITableView()
    
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
            snapshot.appendSections([.todo])
            snapshot.appendItems(schedules)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
}


class DoingView: UIView {
    enum Section: CaseIterable {
        case doing
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, Schedule>?
    
    private let tableView = UITableView()
    
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
            snapshot.appendSections([.doing])
            snapshot.appendItems(schedules)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
}

class DoneView: UIView {
    enum Section: CaseIterable {
        case done
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, Schedule>?
    
    private let tableView = UITableView()
    
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
            snapshot.appendSections([.done])
            snapshot.appendItems(schedules)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
}
