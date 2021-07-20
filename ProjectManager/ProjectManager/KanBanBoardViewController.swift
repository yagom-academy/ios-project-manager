//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

class KanBanBoardViewController: UIViewController {
    // 3개의 datasource
    let toDoArray = ["todo", "todo", "totoo"]
    let doingArray = ["doing", "doing", "doingggg"]
    let doneArray = ["done", "done", "doneee"]

    let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    let toDoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(KanBanBoardCell.self, forCellReuseIdentifier: KanBanBoardCell.reuseIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)

        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self

        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self

        toDoTableView.tableHeaderView = {
            let view = UIView()
            let label = UILabel()
            view.addSubview(label)
            label.snp.makeConstraints { label in
                label.edges.equalTo(view)
            }
            label.text = "TODO"
            return view
        }()

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
        // 각각의 table마다 분기처리를 통해 data를 넣어주는 방식
        switch tableView {
        case self.toDoTableView:
            return toDoArray.count
        case self.doingTableView:
            return doingArray.count
        case self.doneTableView:
            return doneArray.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: KanBanBoardCell.reuseIdentifier,
            for: indexPath
        ) as? KanBanBoardCell
        else {
            return UITableViewCell()
        }

        switch tableView {
        case self.toDoTableView:
            cell.titleLabel.text = toDoArray[indexPath.row]
        case self.doingTableView:
            cell.titleLabel.text = doingArray[indexPath.row]
        case self.doneTableView:
            cell.titleLabel.text = doneArray[indexPath.row]
        default:
            break
        }

        return cell
    }
}

// MARK: - Delegate

extension KanBanBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)

        let statusLabel: UILabel = {
            let label = UILabel()
            label.text = "TEST"
            return label
        }()

        let countLabel: UILabel = {
            let label = UILabel()
            label.text = "13"
            return label
        }()

        view.addSubview(statusLabel)
        view.addSubview(countLabel)

        statusLabel.snp.makeConstraints { label in
            label.leading.equalTo(view).inset(10)
            label.top.equalTo(view).inset(10)
        }

        countLabel.snp.makeConstraints { label in
            label.leading.equalTo(statusLabel.snp.trailing).offset(10)
            label.top.equalTo(view).inset(10)
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
