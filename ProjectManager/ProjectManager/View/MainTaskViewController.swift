//
//  ProjectManager - MainTaskViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainTaskViewController: UIViewController {
    // MARK: - Properties

    private let taskTableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let taskInWaitingTableView = TaskTableView(state: .waiting)
    private let taskInProgressTableView = TaskTableView(state: .progress)
    private let taskInDoneTableView = TaskTableView(state: .done)
    
    private let taskListViewModel: TaskListViewModel
    
    // MARK: - Life Cycle

    init(taskListViewModel: TaskListViewModel) {
        self.taskListViewModel = taskListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("스토리보드 사용하지 않음")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTaskListViewModel()
        setupLongPressGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskListViewModel.onViewWillAppear()
    }
    
    // MARK: - Configure ViewModel

    private func configureTaskListViewModel() {
        taskListViewModel.reloadTableViews = { [weak self] in
            self?.taskInWaitingTableView.reloadData()
            self?.taskInProgressTableView.reloadData()
            self?.taskInDoneTableView.reloadData()
        }
        
        taskListViewModel.reloadTableView = { [weak self] in
            self?.taskInWaitingTableView.reloadData()
        }
        
        taskListViewModel.deleteRows = { [weak self] (index, state) in
            let indexPath = IndexPath(row: index, section: 0)
            let taskTableView = self?.fetchTaskTableView(with: state)
            taskTableView?.deleteRows(at: [indexPath], with: .fade)
        }
        
        taskListViewModel.reloadRows = { [weak self] (index, state) in
            let indexPath = IndexPath(row: index, section: 0)
            let taskTableView = self?.fetchTaskTableView(with: state)
            taskTableView?.reloadRows(at: [indexPath], with: .fade)
        }
        
        taskListViewModel.moveRows = { [weak self] (index, oldState, newState) in
            let indexPath = IndexPath(row: index, section: 0)
            let prevTaskTableView = self?.fetchTaskTableView(with: oldState)
            prevTaskTableView?.deleteRows(at: [indexPath], with: .fade)
            
            let currentTaskTableView = self?.fetchTaskTableView(with: newState)
            currentTaskTableView?.reloadData()
        }
        
        taskListViewModel.presentTaskManageView = { [weak self] taskManageViewModel in
            self?.presentTaskManageViewController(with: taskManageViewModel)
        }
        
        taskListViewModel.taskCount = { [weak self] items in
            items.forEach {
                self?.refreshTaskTableHeader(state: $0.state, count: $0.count)
            }
        }
    }
    
    private func fetchTaskTableView(with state: TaskState) -> TaskTableView {
        switch state {
        case .waiting:
            return taskInWaitingTableView
        case .progress:
            return taskInProgressTableView
        case .done:
            return taskInDoneTableView
        }
    }
    
    private func presentTaskManageViewController(with taskManageViewModel: TaskManageViewModel) {
        let taskManageViewController = TaskManageViewController(taskManageViewModel: taskManageViewModel, delegate: self)
        let taskManageNavigationViewController = UINavigationController(rootViewController: taskManageViewController)
        taskManageNavigationViewController.modalPresentationStyle = .formSheet
        
        present(taskManageNavigationViewController, animated: true, completion: nil)
    }
    
    private func refreshTaskTableHeader(state: TaskState, count: Int) {
        let taskTableView = fetchTaskTableView(with: state)
        let taskTableHeaderView = taskTableView.headerView(forSection: 0) as? TaskTableHeaderView
        taskTableHeaderView?.configureUI(state: state, count: count)
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        configureNavigationController()
        configureTableView()
        configureLayout()
    }
    
    private func configureTableView() {
        [taskInWaitingTableView, taskInProgressTableView, taskInDoneTableView].forEach {
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    private func configureLayout() {
        [taskInWaitingTableView, taskInProgressTableView, taskInDoneTableView].forEach {
            taskTableStackView.addArrangedSubview($0)
        }
        
        view.addSubview(taskTableStackView)
        
        NSLayoutConstraint.activate([
            taskTableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            taskTableStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTableStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavigationController() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }
    
    @objc private func addTask() {
        taskListViewModel.addTask()
    }
    
    // MARK: - Long Press Gesture

    private func setupLongPressGesture() {
        let longPressOnWaiting = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressOnWaiting(_:)))
        let longPressOnProgress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressOnProgress(_:)))
        let longPressOnDone = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressOnDone(_:)))

        taskInWaitingTableView.addGestureRecognizer(longPressOnWaiting)
        taskInProgressTableView.addGestureRecognizer(longPressOnProgress)
        taskInDoneTableView.addGestureRecognizer(longPressOnDone)
    }
    
    private func createAlert(with newStates: [TaskState], completion: @escaping (TaskState) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        newStates.forEach { state in
            let moveAction = UIAlertAction(title: state.relocationTitle, style: .default) { _ in
                completion(state)
            }
            alert.addAction(moveAction)
        }
        
        return alert
    }
    
    private func longPressToMove(gesture: UILongPressGestureRecognizer, tableView: TaskTableView, from oldState: TaskState, to newStates: [TaskState]) {
        let touchPoint = gesture.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else {
            return
        }
        
        if gesture.state == .began {
            let alert = createAlert(with: newStates) { state in
                self.taskListViewModel.moveTask(at: indexPath.row, from: oldState, to: state)
            }

            alert.popoverPresentationController?.sourceView = tableView.cellForRow(at: indexPath)
            present(alert, animated: true)
        }
    }
    
    @objc private func handleLongPressOnWaiting(_ sender: UILongPressGestureRecognizer) {
        longPressToMove(gesture: sender, tableView: taskInWaitingTableView, from: .waiting, to: [.progress, .done])
    }
    
    @objc private func handleLongPressOnProgress(_ sender: UILongPressGestureRecognizer) {
        longPressToMove(gesture: sender, tableView: taskInProgressTableView, from: .progress, to: [.waiting, .done])
    }
    
    @objc private func handleLongPressOnDone(_ sender: UILongPressGestureRecognizer) {
        longPressToMove(gesture: sender, tableView: taskInDoneTableView, from: .done, to: [.waiting, .progress])
    }
}

// MARK: - UITableViewDataSource

extension MainTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = (tableView as? TaskTableView)?.state else {
            return .zero
        }
        
        return taskListViewModel.count(of: state)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskTableViewCell.self, for: indexPath)
        guard let state = (tableView as? TaskTableView)?.state,
              let task = taskListViewModel.task(at: indexPath.row, from: state) else {
            return TaskTableViewCell()
        }
                
        cell.configureCell(with: task)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withClass: TaskTableHeaderView.self)
        
        guard let state = (tableView as? TaskTableView)?.state else {
            return TaskTableHeaderView()
        }
        
        let taskCounts = taskListViewModel.count(of: state)
        headerView.configureUI(state: state, count: taskCounts)
        return headerView
    }
}

// MARK: - UITableViewDelegate

extension MainTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let state = (tableView as? TaskTableView)?.state else {
            return
        }
        
        taskListViewModel.selectTask(at: indexPath.row, from: state)        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            guard let state = (tableView as? TaskTableView)?.state else {
                return
            }
            
            self.taskListViewModel.deleteTask(at: indexPath.row, from: state)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

extension MainTaskViewController: TaskManageViewDelegate {
    func taskManageViewDidCreate(with task: Task) {
        taskListViewModel.createTask(with: task)
    }
    
    func taskManageViewDidUpdate(at index: Int, with task: Task) {
        taskListViewModel.updateTask(at: index, task: task)
    }
}
