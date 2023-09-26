//
//  ToDoViewController.swift
//  ProjectManager
//
//  Created by Max on 2023/09/26.
//

import UIKit

class ToDoListChildViewController: UIViewController {
    private let status: ToDoStatus
    private let headerView: ToDoListHeaderView
    private let viewModel: ToDoListChildViewModel
    
    let today = Date().timeIntervalSinceReferenceDate
    private let dateFormatter: DateFormatter
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tag = 0
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.98, alpha: 1)
        return tableView
    }()
    
    init(_ status: ToDoStatus, viewModel: ToDoListChildViewModel, dateFormatter: DateFormatter) {
        self.status = status
        self.headerView = ToDoListHeaderView(status)
        self.dateFormatter = dateFormatter
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBinding()
    }

    private func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: status.rawValue)
    }
    
    func reloadTableView() {
        tableView.reloadData()
        headerView.setupTotalCount(viewModel.entityList.value.count)
    }
}

extension ToDoListChildViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.entityList.value.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: status.rawValue,
                                                       for: indexPath) as?
                ToDoListTableViewCell else { return UITableViewCell() }
        
        let toDoEntity = viewModel.entityList.value[indexPath.row]
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
            let selectedEntity = self.viewModel.entityList.value[indexPath.row]
            self.viewModel.deleteData(selectedEntity)
        }
        
        delete.backgroundColor = .systemRed
        delete.title = "Delete"
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension ToDoListChildViewController {
    private func setupBinding() {
        viewModel.entityList.bind { [weak self] _ in
            guard let self else { return }
            self.reloadTableView()
        }
        
        viewModel.error.bind { [weak self] _ in
            guard let self,
                  let error = viewModel.error.value else { return }
            let alertBuilder = AlertBuilder(viewController: self, prefferedStyle: .alert)
            alertBuilder.setControllerTitle(title: error.alertTitle)
            alertBuilder.setControllerMessage(message: error.alertMessage)
            alertBuilder.addAction(.confirm)
            let alertController = alertBuilder.makeAlertController()
            present(alertController, animated: true)
        }
    }
    
}
