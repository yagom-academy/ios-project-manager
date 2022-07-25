//
//  HistoryPopOverViewController.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 25/07/2022.
//

import UIKit

class HistoryPopOverViewController: UIViewController {
    
    private typealias DataSource = UITableViewDiffableDataSource<Int, History>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, History>
    
    private let mainView = HistoryPopOverView()
    private var dataSource: DataSource?
    
    init(historys: [History]) {
        super.init(nibName: nil, bundle: nil)
        dataSource = makeDataSource(historys: historys)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        setUpTableView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Functions

extension HistoryPopOverViewController {
    private func setUpTableView() {
        let tableView = mainView.baseTableView
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    private func makeDataSource(historys: [History]) -> DataSource? {
    
        let dataSource = DataSource(tableView: mainView.baseTableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier,
                                                     for: indexPath) as? HistoryCell
            cell?.setUpLabel(history: item)
            return cell
        })
        let snapshot = makeSnapshot(historys: historys)
        
        dataSource.apply(snapshot)
        return dataSource
    }
    
    private func makeSnapshot(historys: [History]) -> Snapshot {
        var snapshot = Snapshot()
        
        snapshot.appendSections([0])
        snapshot.appendItems(historys)
        
        return snapshot
    }
}
