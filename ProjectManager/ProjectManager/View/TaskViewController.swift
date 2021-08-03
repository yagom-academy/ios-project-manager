//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

class TaskViewController: UIViewController {
    private let todoHeadView = HeadView()
    private let doingHeadView = HeadView()
    private let doneHeadView = HeadView()

    private let headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private let todoTableView = TaskTableView()
    private let doingTableView = TaskTableView()
    private let doneTableView = TaskTableView()

    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private func setNavigation() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: nil,
                                                                 action: nil)
    }

    private func setMainView() {
        self.view.addSubview(headStackView)
        self.view.addSubview(tableStackView)
        self.view.backgroundColor = .systemBackground
    }

    private func setHeadView() {
        // TODO: setLabelText 메서드의 countNumber를 tableView의 자료 갯수만큼 카운트 하도록 변경 필요
        todoHeadView.setLabelText(classification: "TODO",
                                  countNumber: todoTableView.countTasks().description)
        doingHeadView.setLabelText(classification: "DOING",
                                   countNumber: doingTableView.countTasks().description)
        doneHeadView.setLabelText(classification: "DONE",
                                  countNumber: doneTableView.countTasks().description)

        [todoHeadView, doingHeadView, doneHeadView].forEach { headView in
            headStackView.addArrangedSubview(headView)
        }

        headStackView.snp.makeConstraints { stackView in
            stackView.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

    }

    private func setTableView() {
        [todoTableView, doingTableView, doneTableView].forEach { tableView in
            self.tableStackView.addArrangedSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
        }

        tableStackView.snp.makeConstraints { stackView in
            stackView.top.equalTo(headStackView.snp.bottom)
            stackView.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setMainView()
        setHeadView()
        setTableView()
    }
}

// MARK: - TableView Delegate
extension TaskViewController: UITableViewDelegate {

}

// MARK: - TableView DataSource
extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let taskTableView = tableView as? TaskTableView else { return 0 }

        return taskTableView.countTasks()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? TaskTableViewCell,
              let taskTableView = tableView as? TaskTableView else { return UITableViewCell()}

        let task = taskTableView.checkTask(index: indexPath.row)
        cell.setLabelText(title: task.title, context: task.context, deadline: task.deadline)
        return cell
    }
}
