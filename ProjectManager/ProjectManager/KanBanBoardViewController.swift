//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

class KanBanBoardViewController: UIViewController {
    let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    let toDoTableView: KanBanTableView = {
        let tableView = KanBanTableView()
        tableView.statusName = "TODO"
        tableView.tasks = ["todo", "todo", "totoo"]
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    let doingTableView: KanBanTableView = {
        let tableView = KanBanTableView()
        tableView.statusName = "DOING"
        tableView.tasks = ["doing", "doing", "doingggg"]
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    let doneTableView: KanBanTableView = {
        let tableView = KanBanTableView()
        tableView.statusName = "DONE"
        tableView.tasks = ["done", "done", "doneee"]
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)

        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self

        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self

        view.addSubview(outerStackView)

        outerStackView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        outerStackView.addArrangedSubview(toDoTableView)
        outerStackView.addArrangedSubview(doingTableView)
        outerStackView.addArrangedSubview(doneTableView)

    }
}

// MARK: - DataSource

extension KanBanBoardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? KanBanTableView else { return 0 }
        return tableView.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: KanBanBoardCell.reuseIdentifier,
            for: indexPath
        ) as? KanBanBoardCell,
        let tableView = tableView as? KanBanTableView
        else {
            return UITableViewCell()
        }

        cell.titleLabel.text = tableView.tasks[indexPath.row]

        return cell
    }
}

// MARK: - Delegate

extension KanBanBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tableView = tableView as? KanBanTableView else { return .none }

        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray
//        view.translatesAutoresizingMaskIntoConstraints = false // 왜 snapkit쓰면 이걸 안해줘도 되는지??

        let statusLabel: UILabel = {
            let label = UILabel()
            label.text = tableView.statusName
            return label
        }()

        let countLabel: UILabel = {
            let label = UILabel()
            label.text = tableView.tasks.count.description
            return label
        }()

        view.addSubview(statusLabel)
        view.addSubview(countLabel)

        statusLabel.snp.makeConstraints { label in
            label.leading.equalTo(view).inset(10)
            label.centerY.equalTo(view)
        }

        countLabel.snp.makeConstraints { label in
            label.leading.equalTo(statusLabel.snp.trailing).offset(10)
            label.centerY.equalTo(view)
        }

        return view
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive,
                               title: "delete",
                               handler: { _, _, _ in })
        ])
    }
}
