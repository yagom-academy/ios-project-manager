//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

final class KanBanBoardViewController: UIViewController {
    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    // TODO: status 대소문자 통일 필요
    // TODO: 무수히 많은 switch문들 해결 필요

    private let toDoTableView: KanBanTableView = {
        let tableView = KanBanTableView(statusName: "TODO")
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    private let doingTableView: KanBanTableView = {
        let tableView = KanBanTableView(statusName: "DOING")
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    private let doneTableView: KanBanTableView = {
        let tableView = KanBanTableView(statusName: "DONE")
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
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
        setUpOuterStackView()
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

    private func setUpOuterStackView() {
        view.addSubview(outerStackView)
        outerStackView.snp.makeConstraints { $0.edges.equalTo(view) }

        outerStackView.addArrangedSubview(toDoTableView)
        outerStackView.addArrangedSubview(doingTableView)
        outerStackView.addArrangedSubview(doneTableView)
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

        switch tableView.statusName {
        case "TODO":
            return TaskManager.shared.toDoTasks.count
        case "DOING":
            return TaskManager.shared.doingTasks.count
        case "DONE":
            return TaskManager.shared.doneTasks.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KanBanBoardCell.reuseIdentifier,
                                                       for: indexPath) as? KanBanBoardCell,
              let tableView = tableView as? KanBanTableView else { return UITableViewCell() }

        switch tableView.statusName {
        case "toDo":
            cell.setText(title: "title", description: "des", date: "123")
            cell.setText(
                title: TaskManager.shared.toDoTasks[indexPath.row].title,
                description: TaskManager.shared.toDoTasks[indexPath.row].description,
                date: TaskManager.shared.toDoTasks[indexPath.row].date.description
            )
        case "doing":
            cell.setText(
                title: TaskManager.shared.doingTasks[indexPath.row].title,
                description: TaskManager.shared.doingTasks[indexPath.row].description,
                date: TaskManager.shared.doingTasks[indexPath.row].date.description
            )
        case "done":
            cell.setText(
                title: TaskManager.shared.doneTasks[indexPath.row].title,
                description: TaskManager.shared.doneTasks[indexPath.row].description,
                date: TaskManager.shared.doneTasks[indexPath.row].date.description
            )
        default:
            break
        }

        return cell
    }
}

// MARK: - TableView Delegate

extension KanBanBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tableView = tableView as? KanBanTableView else { return .none }

        let view = UIView()
        view.backgroundColor = .systemGray

        let statusLabel: UILabel = {
            let label = UILabel()
            label.text = tableView.statusName
            label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            return label
        }()

        let countLabel: UILabel = {
            let label = UILabel()
            label.text = "temp"
            label.clipsToBounds = true
            label.textAlignment = .center
            label.layer.borderWidth = 2
            label.layer.cornerRadius = 5
            label.layer.borderColor = UIColor.black.cgColor
            label.font = UIFont.preferredFont(forTextStyle: .body)
            return label
        }()

        view.addSubview(statusLabel)
        view.addSubview(countLabel)

        statusLabel.snp.makeConstraints { label in
            label.top.equalTo(view).inset(10)
            label.leading.equalTo(view).inset(10)
            label.centerY.equalTo(view)
            label.bottom.equalTo(view).inset(10)
        }

        countLabel.snp.makeConstraints { label in
            label.leading.equalTo(statusLabel.snp.trailing).offset(10)
            label.centerY.equalTo(view)
            label.width.equalTo(25)
            label.height.equalTo(25)
        }

        return view
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextualAction = UIContextualAction(style: .destructive, title: "delete", handler: { _, _, _ in })
        return UISwipeActionsConfiguration(actions: [contextualAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let taskDetailViewController = TaskDetailViewController(mode: .edit, indexPath: indexPath)
        taskDetailViewController.view.backgroundColor = .systemBackground
        taskDetailViewController.modalPresentationStyle = .formSheet
        present(UINavigationController(rootViewController: taskDetailViewController), animated: true, completion: nil)
    }
}

// MARK: - TaskManagerDelegate

extension KanBanBoardViewController: TaskManagerDelegate {
    func taskDidCreated() {
        print(TaskManager.shared.toDoTasks.count)
        toDoTableView.reloadData()
    }

    func taskDidEdited() {

    }

    func taskDidDeleted() {

    }
}
