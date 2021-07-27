//
//  ProjectManager - PMViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class PMViewController: UIViewController {

    private enum Style {

        static let backgroundColor: UIColor = .systemGray4
    }

    var viewModel = TaskViewModel()

    // MARK: Views

    let pmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var stateStackViews: [StateStackView] = []

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.backgroundColor
        setNavigationBar()
        setStateStackViews()
        setPMStackView()
        setSubView()

        bindWithViewModel()
        fetchTasks()
    }

    // MARK: Configure View

    private func setNavigationBar() {
        title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
    }

    private func setStateStackViews() {
        stateStackViews.append(contentsOf: [
            StateStackView(state: .todo, pmDelegate: self),
            StateStackView(state: .doing, pmDelegate: self),
            StateStackView(state: .done, pmDelegate: self)
        ])
    }

    private func setPMStackView() {
        stateStackViews.forEach { pmStackView.addArrangedSubview($0) }
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

    private func bindWithViewModel() {
        viewModel.added = { index in
            DispatchQueue.main.async { [weak self] in
                let indexPaths = [IndexPath(row: index, section: 0)]
                let todoStackView = self?.stateStackViews.filter { $0.state == .todo }.first
                todoStackView?.stateTableView.insertRows(at: indexPaths, with: .none)
            }
        }

        viewModel.changed = {
            DispatchQueue.main.async { [weak self] in
                self?.stateStackViews.forEach {
                    guard let state = $0.state,
                          let taskCount = self?.viewModel.count(of: state) else { return }

                    $0.setTaskCountLabel(as: taskCount)
                }
            }
        }

        viewModel.removed = { state, row in
            let indexPaths = [IndexPath(row: row, section: 0)]
            DispatchQueue.main.async { [weak self] in
                let stackView = self?.stateStackViews.filter { $0.state == state }.first
                stackView?.stateTableView.deleteRows(at: indexPaths, with: .none)
            }
        }

        viewModel.inserted = { state, row in
            let indexPaths = [IndexPath(row: row, section: 0)]
            DispatchQueue.main.async { [weak self] in
                let stackView = self?.stateStackViews.filter { $0.state == state }.first
                stackView?.stateTableView.insertRows(at: indexPaths, with: .none)
            }
        }
    }

    private func fetchTasks() {
        viewModel.fetchTasks {
            DispatchQueue.main.async { [weak self] in
                self?.stateStackViews.forEach { $0.stateTableView.reloadData() }
            }
        }
    }

    // MARK: Button Actions

    @objc private func addButtonTapped() {
        guard let taskEditViewController = TaskEditViewController(editMode: .add) else { return }
        taskEditViewController.delegate = self

        let presented = UINavigationController(rootViewController: taskEditViewController)
        present(presented, animated: true, completion: nil)
    }
}

extension PMViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return 0 }

        return viewModel.taskList[state].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state,
              let taskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier,
                                                           for: indexPath) as? TaskCell else { return TaskCell() }

        let task = viewModel.task(from: state, at: indexPath.row)
        taskCell.configure(with: task)

        return taskCell
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return }

        viewModel.move(in: state, from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}

extension PMViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return }

        stateTableView.deselectRow(at: indexPath, animated: true)

        guard let task = viewModel.task(from: state, at: indexPath.row),
            let taskEditViewController = TaskEditViewController(editMode: .update,
                                                                task: (indexPath, task)) else { return }

        taskEditViewController.delegate = self

        let presented = UINavigationController(rootViewController: taskEditViewController)
        present(presented, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let stateTableView = tableView as? StateTableView,
                  let state = stateTableView.state else { return }
            viewModel.remove(state: state, at: indexPath.row)
        }
    }
}

extension PMViewController: TaskEditViewControllerDelegate {

    func taskWillUpdate(_ task: Task, _ indexPath: IndexPath) {
        let stackView = stateStackViews.filter { $0.state == task.state }.first
        stackView?.stateTableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func taskWillAdd(_ task: Task) {
        viewModel.add(task)
    }
}
