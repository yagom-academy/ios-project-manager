//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    var viewModel = TaskViewModel()

    let pmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var todoStackView: StateStackView = StateStackView(state: .todo, delegate: self)
    lazy var doingStackView: StateStackView = StateStackView(state: .doing, delegate: self)
    lazy var doneStackView: StateStackView = StateStackView(state: .done, delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setSubView()
        pmStackView.addArrangedSubview(todoStackView)
        pmStackView.addArrangedSubview(doingStackView)
        pmStackView.addArrangedSubview(doneStackView)

        viewModel.fetchTasks {
            DispatchQueue.main.async {
                self.todoStackView.stateTableView.reloadData()
                self.doingStackView.stateTableView.reloadData()
                self.doneStackView.stateTableView.reloadData()
            }
        }
    }

    private func setSubView() {
        view.addSubview(pmStackView)
        NSLayoutConstraint.activate([
            pmStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pmStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pmStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pmStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoStackView.stateTableView:
            return viewModel.taskOrder[.todo].count
        case doingStackView.stateTableView:
            return viewModel.taskOrder[.doing].count
        case doneStackView.stateTableView:
            return viewModel.taskOrder[.done].count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier,
                                                           for: indexPath) as? TaskCell else { return TaskCell() }

        switch tableView {
        case todoStackView.stateTableView:
            let todoTask = viewModel.task(from: .todo, at: indexPath.row)
            taskCell.configure(with: todoTask)
        case doingStackView.stateTableView:
            let doingTask = viewModel.task(from: .doing, at: indexPath.row)
            taskCell.configure(with: doingTask)
        case doneStackView.stateTableView:
            let doneTask = viewModel.task(from: .done, at: indexPath.row)
            taskCell.configure(with: doneTask)
        default:
            break
        }

        return taskCell
    }
}
