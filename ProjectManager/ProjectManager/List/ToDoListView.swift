//
//  ToDoListView.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import UIKit

class ToDoListView: UIView {
    private let viewModel: ViewModelProtocol
    private let status: ToDoStatus
    private let headerView: ToDoListHeaderView
    let today = Date().timeIntervalSinceReferenceDate
    
    var toDoEntities: [ToDo] {
        switch status {
        case .toDo:
            return viewModel.toDoList.value
        case .doing:
            return viewModel.doingList.value
        case .done:
            return viewModel.doneList.value
        }
    }
    
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
    
    init(_ status: ToDoStatus, viewModel: ViewModelProtocol) {
        self.status = status
        self.viewModel = viewModel
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
        tableView.register(ToDoListViewCell.self, forCellReuseIdentifier: status.rawValue)
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
        self.headerView.setupTotalCount(self.toDoEntities.count)
    }
}

extension ToDoListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoEntities.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: status.rawValue,
                                                       for: indexPath) as?
                ToDoListViewCell else { return UITableViewCell() }
        
        let toDoEntity = toDoEntities[indexPath.row]
        let isDone = toDoEntity.status == ToDoStatus.done.rawValue
        let isPast = floor(today/86400) > floor(toDoEntity.dueDate.timeIntervalSinceReferenceDate/86400) && !isDone
        let date = dateFormatter.string(from: toDoEntity.dueDate)
        
        cell.setupUI()
        cell.setModel(title: toDoEntity.title, date: date, body: toDoEntity.body, isPast: isPast)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { (_, _, success: @escaping (Bool) -> Void) in
            let selectedEntity = self.toDoEntities[indexPath.row]
            self.viewModel.deleteData(selectedEntity)
        }
        
        delete.backgroundColor = .systemRed
        delete.title = "Delete"
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
