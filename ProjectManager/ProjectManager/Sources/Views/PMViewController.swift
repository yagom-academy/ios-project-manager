//
//  ProjectManager - PMViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import Network

final class PMViewController: UIViewController {

    private enum Style {
        static let backgroundColor: UIColor = .systemGray4

        static let pmStackViewSpacing: CGFloat = 10

        static let navigationTitle: String = "Project Manager"
        static let navigationLeftBarButtonTitle: String = "History"

        static let historyViewSize = CGSize(width: UIScreen.main.bounds.width * 0.4,
                                            height: UIScreen.main.bounds.height * 0.6)

        static let networkDisconnectedText: String = "😵 현재 오프라인 상태입니다."
        static let networkStatusLabelPresentTime: TimeInterval = 0.3
        static let networkQueueName: String = "Network"
    }

    var viewModel = TaskViewModel()
    let historyViewModel = HistoryViewModel()
    private var stateStackViews: [StateStackView] = []

    private(set) var isConnected: Bool = false {
        didSet {
            isConnected ? viewModel.networkDidConnect() : viewModel.networkDidDisconnect()
            showNetworkStatus(at: isConnected)
        }
    }

    // MARK: Views

    private lazy var historyViewController: HistoryViewController = {
        let historyViewController = HistoryViewController()
        historyViewController.modalPresentationStyle = .popover
        historyViewController.preferredContentSize = Style.historyViewSize
        historyViewController.viewModel = historyViewModel
        return historyViewController
    }()

    let pmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = Style.pmStackViewSpacing
        stackView.distribution = .fillEqually
        stackView.backgroundColor = Style.backgroundColor
        return stackView
    }()

    let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let networkStatusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = Style.networkDisconnectedText
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setNavigationBar()
        setStateStackViews()
        setPMStackView()
        setRootStackView()
        setSubView()

        bindWithViewModel()
        monitorNetwork()
    }

    // MARK: Configure View

    private func setAttributes() {
        view.backgroundColor = Style.backgroundColor
    }

    private func setNavigationBar() {
        title = Style.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Style.navigationLeftBarButtonTitle,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(historyButtonTapped))
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

    private func setRootStackView() {
        rootStackView.addArrangedSubview(networkStatusLabel)
        rootStackView.addArrangedSubview(pmStackView)
    }

    private func setSubView() {
        view.addSubview(rootStackView)
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func bindWithViewModel() {
        viewModel.added = { index in
            DispatchQueue.main.async { [weak self] in
                let indexPaths = [IndexPath(row: index, section: .zero)]
                let todoStackView = self?.stateStackViews.filter { $0.state == .todo }.first
                todoStackView?.stateTableView.insertRows(at: indexPaths, with: .none)
            }
        }

        viewModel.changed = { frontCount in
            DispatchQueue.main.async { [weak self] in
                if frontCount == 0 {
                    self?.stateStackViews.forEach { stateStackView in
                        stateStackView.showTaskCountLabel()
                        stateStackView.stateTableView.reloadSections(IndexSet(0...0), with: .automatic)
                    }
                }

                self?.stateStackViews.forEach {
                    guard let state = $0.state,
                          let taskCount = self?.viewModel.count(of: state) else { return }

                    $0.setTaskCountLabel(as: taskCount)
                }
            }
        }

        viewModel.removed = { state, row in
            let indexPaths = [IndexPath(row: row, section: .zero)]
            DispatchQueue.main.async { [weak self] in
                let stackView = self?.stateStackViews.filter { $0.state == state }.first
                stackView?.stateTableView.deleteRows(at: indexPaths, with: .none)
            }
        }

        viewModel.inserted = { state, row in
            let indexPaths = [IndexPath(row: row, section: .zero)]
            DispatchQueue.main.async { [weak self] in
                let stackView = self?.stateStackViews.filter { $0.state == state }.first
                stackView?.stateTableView.insertRows(at: indexPaths, with: .none)
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

    @objc private func historyButtonTapped() {
        historyViewController.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(historyViewController, animated: true, completion: nil)
    }

    // MARK: Network Monitoring

    private func monitorNetwork() {
        let networkMonitor = NWPathMonitor()

        networkMonitor.pathUpdateHandler = { [weak self] nwPath in
            switch nwPath.status {
            case .satisfied:
                self?.isConnected = true
            case .unsatisfied:
                self?.isConnected = false
            default:
                break
            }
        }
        let networkQueue = DispatchQueue(label: Style.networkQueueName)
        networkMonitor.start(queue: networkQueue)
    }

    private func showNetworkStatus(at status: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: Style.networkStatusLabelPresentTime) { [weak self] in
                self?.networkStatusLabel.isHidden = status
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension PMViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return .zero }

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

// MARK: - UITableViewDelegate

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
        guard editingStyle == .delete,
              let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return }

        if let removedTitle = viewModel.remove(state: state, at: indexPath.row) {
            historyViewModel.create(history: History(method: .removed(title: removedTitle, sourceState: state)))
        }
    }
}

// MARK: - TaskEditViewControllerDelegate

extension PMViewController: TaskEditViewControllerDelegate {

    func taskWillUpdate(_ task: Task, _ indexPath: IndexPath) {
        viewModel.update(task)
        let stackView = stateStackViews.filter { $0.state == task.taskState }.first
        stackView?.stateTableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func taskWillAdd(_ task: Task) {
        viewModel.add(task)
        historyViewModel.create(history: History(method: .added(title: task.title)))
    }
}
