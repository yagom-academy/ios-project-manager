//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

final class KanBanBoardViewController: UIViewController {
    private let toDoHeaderView = TaskTableHeaderView()

    private let doingHeaderView = TaskTableHeaderView()

    private let doneHeaderView = TaskTableHeaderView()

    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private let toDoTableView: KanBanTableView = {
        let tableView = KanBanTableView(status: .TODO)
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    private let doingTableView: KanBanTableView = {
        let tableView = KanBanTableView(status: .DOING)
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    private let doneTableView: KanBanTableView = {
        let tableView = KanBanTableView(status: .DONE)
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        TaskManager.shared.taskManagerDelegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setTableViewDelegate()
        setTableViewDataSource()
        setUpHeaderStackView()
        setUpTableStackView()
    }

    private func setUpView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(touchUpTaskAddButton)
        )
    }

    private func setTableViewDataSource() {
        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
    }

    private func setTableViewDelegate() {
        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
    }

    private func setUpHeaderStackView() {
        view.addSubview(headerStackView)

        headerStackView.snp.makeConstraints { stackView in
            stackView.top.equalTo(view.safeAreaLayoutGuide)
            stackView.leading.equalTo(view.safeAreaLayoutGuide)
            stackView.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        headerStackView.addArrangedSubview(toDoHeaderView)
        headerStackView.addArrangedSubview(doingHeaderView)
        headerStackView.addArrangedSubview(doneHeaderView)

        toDoHeaderView.setText(
            status: TaskStatus.TODO.rawValue,
            count: TaskManager.shared.toDoTasks.count.description)

        doingHeaderView.setText(
            status: TaskStatus.DOING.rawValue,
            count: TaskManager.shared.doingTasks.count.description
        )

        doneHeaderView.setText(
            status: TaskStatus.DONE.rawValue,
            count: TaskManager.shared.doneTasks.count.description
        )
    }

    private func setUpTableStackView() {
        view.addSubview(tableStackView)
        tableStackView.snp.makeConstraints { stackView in
            stackView.top.equalTo(headerStackView.snp.bottom)
            stackView.leading.equalTo(view)
            stackView.trailing.equalTo(view)
            stackView.bottom.equalTo(view)
        }

        tableStackView.addArrangedSubview(toDoTableView)
        tableStackView.addArrangedSubview(doingTableView)
        tableStackView.addArrangedSubview(doneTableView)
    }

    @objc func touchUpTaskAddButton() {
        let taskDetailViewController = TaskDetailViewController(mode: .add)
        taskDetailViewController.view.backgroundColor = .systemBackground
        taskDetailViewController.modalPresentationStyle = .formSheet
        present(UINavigationController(rootViewController: taskDetailViewController), animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource

extension KanBanBoardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? KanBanTableView else { return 0 }
        return tableView.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KanBanBoardCell.reuseIdentifier,
                                                       for: indexPath) as? KanBanBoardCell,
              let tableView = tableView as? KanBanTableView else { return UITableViewCell() }

        let task = tableView.tasks[indexPath.row]
        cell.setText(title: task.title, description: task.body, date: task.date.description)
        return cell
    }
}

// MARK: - TableView Delegate

extension KanBanBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let tableView = tableView as? KanBanTableView else { return nil }

        let contextualAction = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            TaskManager.shared.deleteTask(indexPath: indexPath, status: tableView.status)
        }
        return UISwipeActionsConfiguration(actions: [contextualAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableView = tableView as? KanBanTableView else { return }

        let taskDetailViewController = TaskDetailViewController(
            mode: .edit,
            status: tableView.status,
            indexPath: indexPath
        )

        taskDetailViewController.view.backgroundColor = .systemBackground
        taskDetailViewController.modalPresentationStyle = .formSheet
        present(UINavigationController(rootViewController: taskDetailViewController), animated: true, completion: nil)
    }
}

// MARK: - TaskManagerDelegate

extension KanBanBoardViewController: TaskManagerDelegate {
    func taskDidCreated() {
        toDoHeaderView.countLabel.text = TaskManager.shared.toDoTasks.count.description
        toDoTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }

    func taskDidEdited(indexPath: IndexPath, status: TaskStatus) {
        switch status {
        case .TODO:
            toDoTableView.reloadRows(at: [indexPath], with: .automatic)
            toDoHeaderView.countLabel.text = TaskManager.shared.toDoTasks.count.description
        case .DOING:
            doingTableView.reloadRows(at: [indexPath], with: .automatic)
            doingHeaderView.countLabel.text = TaskManager.shared.doingTasks.count.description
        case .DONE:
            doneTableView.reloadRows(at: [indexPath], with: .automatic)
            doneHeaderView.countLabel.text = TaskManager.shared.doneTasks.count.description
        }
    }

    func taskDidDeleted(indexPath: IndexPath, status: TaskStatus) {
        switch status {
        case .TODO:
            toDoTableView.deleteRows(at: [indexPath], with: .automatic)
            toDoHeaderView.countLabel.text = TaskManager.shared.toDoTasks.count.description
        case .DOING:
            doingTableView.deleteRows(at: [indexPath], with: .automatic)
            doingHeaderView.countLabel.text = TaskManager.shared.doingTasks.count.description
        case .DONE:
            doneTableView.deleteRows(at: [indexPath], with: .automatic)
            doneHeaderView.countLabel.text = TaskManager.shared.doneTasks.count.description
        }
    }
}
