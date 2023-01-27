//  ProjectManager - HistoryTableViewController.swift
//  created by zhilly on 2023/01/27

import UIKit

final class HistoryTableViewController: UITableViewController {
    
    enum Schedule: Hashable {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Schedule, History>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, History>
    
    let viewModel: HistoryViewModel
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HistoryCell.reuseIdentifier,
                for: indexPath
            ) as? HistoryCell else { return UITableViewCell() }
            
            cell.configure(with: item)
            
            return cell
        }
        
        return dataSource
    }()
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.reuseIdentifier)
        
        self.setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.model.bind { [weak self] item in
            self?.appendData(item: item)
            self?.tableView.reloadData()
        }
    }
    
    private func appendData(item: [History]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(item)
        dataSource.apply(snapshot)
    }
}
