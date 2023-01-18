//  ProjectManager - ToDoListView.swift
//  created by zhilly on 2023/01/16

import UIKit

class ToDoListView: UIView {
    enum Schedule: Hashable {
        case main
    }
    
    private let status: ToDoState
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderHeight = 50
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource = {
        let dataSource = UITableViewDiffableDataSource<Schedule, ToDo>(
            tableView: tableView
        ) { tableView, indexPath, _ in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ToDoCell.reuseIdentifier,
                for: indexPath
            ) as? ToDoCell else { return nil }
            
            cell.configure(title: "제목 : \(indexPath)")
            
            return cell
        }
        
        return dataSource
    }()
    
    init(status: ToDoState) {
        self.status = status
        super.init(frame: .zero)
        tableView.delegate = self
        setupView()
        appendData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func appendData() {
        var snapshot = NSDiffableDataSourceSnapshot<Schedule, ToDo>()
        snapshot.appendSections([.main])
        snapshot.appendItems([ToDo(title: "1번째", body: "바디", deadline: Date(), state: .toDo)])
        snapshot.appendItems([ToDo(title: "2번째", body: "바디", deadline: Date(), state: .toDo)])

        dataSource.apply(snapshot)
    }
}

extension ToDoListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ToDoHeaderView(status: self.status)

        return headerView
    }
}
}
