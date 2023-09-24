//
//  ToDoListView.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import UIKit

class ToDoListView: UIView {
    weak var viewController: ToDoListViewController?
    private let status: ToDoStatus
    private let headerView: ToDoListHeaderView
    let today = Date().timeIntervalSinceReferenceDate
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tag = 0
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.98, alpha: 1)
        return tableView
    }()
    
    init(_ status: ToDoStatus) {
        self.status = status
        self.headerView = ToDoListHeaderView(status)
        super.init(frame: .init())
        
        setupUI()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoListViewCell.self, forCellReuseIdentifier: status.name)
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
        self.headerView.setupTotalCount(self.viewController?.viewModel.dataList.value[status]?.count ?? 0)
    }
}

extension ToDoListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewController?.viewModel.dataList.value[status]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: status.name,
                                                       for: indexPath) as?
                ToDoListViewCell else { return UITableViewCell() }
        
        guard let data = viewController?.viewModel.dataList.value[status]?[indexPath.row],
              let title = data.title,
              let dueDate = data.dueDate,
              let body = data.body,
              let status = data.status else {
            return UITableViewCell()
        }
        
        let isDone = status == ToDoStatus.done.name
        let isPast = floor(today/86400) > floor(dueDate.timeIntervalSinceReferenceDate/86400) && !isDone
        let date = dateFormatter.string(from: dueDate)
        
        cell.setupUI()
        cell.setModel(title: title, date: date, body: body, isPast: isPast)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
            guard let selectedData = self.viewController?.viewModel.dataList.value[self.status]?[indexPath.row] else {
                return
            }
            self.viewController?.viewModel.deleteData(selectedData)
        }
        
        delete.backgroundColor = .systemRed
        delete.title = "Delete"
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
