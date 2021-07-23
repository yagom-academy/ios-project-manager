//
//  ProjectManager - PMViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class PMViewController: UIViewController {

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
        setNavigationBar()
        setSubView()
        pmStackView.addArrangedSubview(todoStackView)
        pmStackView.addArrangedSubview(doingStackView)
        pmStackView.addArrangedSubview(doneStackView)

        viewModel.added = { [weak self] in
            guard let self = self else { return }
            let indexPaths = [IndexPath(row: self.viewModel.taskOrder.todo.count, section: 0)]
            self.todoStackView.stateTableView.insertRows(at: indexPaths, with: .none)
        }

        viewModel.removed = { [weak self] state, row in
            let indexPaths = [IndexPath(row: row, section: 0)]
            DispatchQueue.main.async {
                switch state {
                case .todo:
                    self?.todoStackView.stateTableView.deleteRows(at: indexPaths, with: .none)
                case .doing:
                    self?.doingStackView.stateTableView.deleteRows(at: indexPaths, with: .none)
                case .done:
                    self?.doneStackView.stateTableView.deleteRows(at: indexPaths, with: .none)
                }
            }
        }

        viewModel.updated = { [weak self] state, row in
            let indexPaths = [IndexPath(row: row, section: 0)]
            switch state {
            case .todo:
                self?.todoStackView.stateTableView.reloadRows(at: indexPaths, with: .none)
            case .doing:
                self?.doingStackView.stateTableView.reloadRows(at: indexPaths, with: .none)
            case .done:
                self?.doneStackView.stateTableView.reloadRows(at: indexPaths, with: .none)
            }
        }

        viewModel.inserted = { [weak self] state, row in
            let indexPaths = [IndexPath(row: row, section: 0)]
            DispatchQueue.main.async {
                switch state {
                case .todo:
                    self?.todoStackView.stateTableView.insertRows(at: indexPaths, with: .none)
                case .doing:
                    self?.doingStackView.stateTableView.insertRows(at: indexPaths, with: .none)
                case .done:
                    self?.doneStackView.stateTableView.insertRows(at: indexPaths, with: .none)
                }
            }
        }

        viewModel.fetchTasks {
            DispatchQueue.main.async {
                self.todoStackView.stateTableView.reloadData()
                self.doingStackView.stateTableView.reloadData()
                self.doneStackView.stateTableView.reloadData()
            }
        }
    }

    private func setNavigationBar() {
        title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
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

    @objc private func addButtonTapped() {
        let taskEditViewController = UINavigationController(rootViewController: TaskEditViewController())
        present(taskEditViewController, animated: true, completion: nil)
    }
}

extension PMViewController: UITableViewDataSource {
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

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        switch tableView {
        case self.todoStackView.stateTableView:
            self.viewModel.move(in: .todo, from: sourceIndexPath.row, to: destinationIndexPath.row)
        case self.doingStackView.stateTableView:
            self.viewModel.move(in: .doing, from: sourceIndexPath.row, to: destinationIndexPath.row)
        case self.doneStackView.stateTableView:
            self.viewModel.move(in: .done, from: sourceIndexPath.row, to: destinationIndexPath.row)
        default:
            break
        }
    }
}

extension PMViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskEditViewController = TaskEditViewController()

        switch tableView {
        case self.todoStackView.stateTableView:
            taskEditViewController.task = viewModel.task(from: .todo, at: indexPath.row)
        case self.doingStackView.stateTableView:
            taskEditViewController.task = viewModel.task(from: .doing, at: indexPath.row)
        case self.doneStackView.stateTableView:
            taskEditViewController.task = viewModel.task(from: .done, at: indexPath.row)
        default:
            break
        }

        present(UINavigationController(rootViewController: taskEditViewController), animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch tableView {
            case todoStackView.stateTableView:
                viewModel.remove(state: .todo, at: indexPath.row)
            case doingStackView.stateTableView:
                viewModel.remove(state: .doing, at: indexPath.row)
            case doneStackView.stateTableView:
                viewModel.remove(state: .done, at: indexPath.row)
            default:
                break
            }
        }
    }
}
