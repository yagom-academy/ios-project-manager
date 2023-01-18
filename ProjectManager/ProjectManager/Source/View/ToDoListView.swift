//  ProjectManager - ToDoListView.swift
//  created by zhilly on 2023/01/16

import UIKit

class ToDoListView: UIView {
    enum Schedule: Hashable {
        case main
    }
    
    private let status: ToDoState
    let viewModel: ToDoListViewModel
    
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
        ) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ToDoCell.reuseIdentifier,
                for: indexPath
            ) as? ToDoCell else { return UITableViewCell() }
            
            cell.configure(title: item.title, body: item.body, deadline: "2023.11.11")
            
            return cell
        }
        
        return dataSource
    }()
    
    init(status: ToDoState, viewModel: ToDoListViewModel) {
        self.status = status
        self.viewModel = viewModel
        super.init(frame: .zero)
        tableView.delegate = self
        setupView()
        
        viewModel.model.bind { item in
            self.appendData(item: item)
        }
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
    
    func appendData(item: [ToDo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Schedule, ToDo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(item)
        
        dataSource.apply(snapshot)
    }
    
    func addToDo(item: ToDo) {
        viewModel.addToDo(item: item)
    }
}

extension ToDoListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ToDoHeaderView(status: self.status)
        
        return headerView
    }
}
