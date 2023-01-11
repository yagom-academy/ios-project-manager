//
//  ToDoListViewController.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import UIKit

final class ToDoListViewController: UIViewController, UITableViewDelegate {
    typealias DataSource = UITableViewDiffableDataSource<Int, ToDo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ToDo>

    private let toDoTableView = ToDoTableView()
    private let doingTableView = ToDoTableView()
    private let doneTableView = ToDoTableView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: view.bounds)
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()

    private lazy var toDoDataSource = configureDataSource()
    private lazy var doingDataSource = configureDataSource()
    private lazy var doneDataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureLayout()
        configureToDoSnapshot()
    }

    private func configureLayout() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(toDoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)

        toDoTableView.dataSource = toDoDataSource
        doingTableView.dataSource = doingDataSource
        doneTableView.dataSource = doneDataSource
    }

    private func makeAddToDoButton() -> UIBarButtonItem {
        let buttonAction = UIAction { _ in
            print("touched addButton")
        }

        let button = UIBarButtonItem(systemItem: .add, primaryAction: buttonAction)

        return button
    }

    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = makeAddToDoButton()
    }

    private func configureCell(_ cell: UITableViewCell, with todo: ToDo) {
        guard let cell = cell as? ToDoTableViewCell else {
            return
        }

        cell.configureCell(with: todo)
    }


    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(tableView: toDoTableView, cellProvider: { tableView, indexPath, todo in
            let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath)
            self.configureCell(cell, with: todo)
            return cell
        })

        return dataSource
    }

    private func configureToDoSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([ToDo(), ToDo(), ToDo()])

        toDoDataSource.apply(snapshot)
        doingDataSource.apply(snapshot)
        doneDataSource.apply(snapshot)
    }
}
