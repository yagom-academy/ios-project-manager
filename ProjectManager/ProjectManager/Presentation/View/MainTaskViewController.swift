//
//  ProjectManager - MainTaskViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainTaskViewController: UIViewController, UINavigationControllerDelegate {
    private let taskStandbyTableView = TaskTableView(projectState: .todo)
    private let taskInProgressTableView = TaskTableView(projectState: .doing)
    private let taskFinishedTableView = TaskTableView(projectState: .done)
    
    private var fetchedViewModels: [TaskViewModel]?
    private lazy var mainTaskService = MainTaskService(output:
            .init(
                showCells: showCells,
                makeNewTask: makeNewTask,
                createCell: createCell,
                showAlert: showAlert,
                moveCell: moveCell,
                deleteCell: deleteCell
            )
    )
    
    private let entireProjectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTaskService.input.viewDidLoad()
        setup()
    }
    
    private func showCells(viewModels: [TaskViewModel]) {
        fetchedViewModels = viewModels
        taskStandbyTableView.reloadData()
    }
    
    private func makeNewTask() {
        let createTaskViewController = CreateTaskViewController()
        let createTaskNavigationViewController = UINavigationController(
            rootViewController: createTaskViewController
        )
        
        createTaskNavigationViewController.modalPresentationStyle = .formSheet
        createTaskViewController.delegate = self
        present(createTaskNavigationViewController, animated: true, completion: nil)
    }

    private func createCell(viewModel: TaskViewModel) {
        fetchedViewModels?.append(viewModel)
        reloadTableView()
    }
    
    private func showAlert(viewModel: TaskViewModel) {
        let editTaskViewController = EditTaskViewController()
        let editTaskNavigationViewController = UINavigationController(
            rootViewController: editTaskViewController
        )
        
        editTaskNavigationViewController.modalPresentationStyle = .formSheet
        editTaskViewController.configureModel(viewModel)
        editTaskViewController.delegate = self
        present(editTaskNavigationViewController, animated: true, completion: nil)
    }
    
    private func moveCell(viewModel: TaskViewModel, changedViewModel: TaskViewModel) {
        guard let index = fetchedViewModels?.firstIndex(of: viewModel) else {
            return
        }
        
        fetchedViewModels?.remove(at: index)
        fetchedViewModels?.append(changedViewModel)
        reloadTableView()
    }
    
    private func deleteCell(index: Int, state: TaskState) {
        fetchedViewModels?.remove(at: index)
        reloadTableView()
    }
}

extension MainTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let task = retrieveTask(by: tableView) else {
            return 0
        }
        
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell",
                                                       for: indexPath) as? TaskListCell,
              let task = retrieveTask(by: tableView) else {
            return UITableViewCell()
        }
        
        cell.configureUI(data: task[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "ProjectHeaderView"
        ) as? TaskHeaderView else {
            return UITableViewHeaderFooterView()
        }
        
        if let state = (tableView as? TaskTableView)?.projectState,
           let count = retrieveTask(by: tableView)?.count {
            headerView.configureUI(title: state.header, count: count)
        }
        
        return headerView
    }
}

extension MainTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = retrieveTask(by: tableView) else {
            return
        }
        
        mainTaskService.input.cellDidTap(indexPath.row, task[indexPath.row].state)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] _, _, _ in
            guard let self = self,
                  let viewModel = self.retrieveTask(by: tableView) else {
                return
            }
            
            self.mainTaskService.input.deleteButtonDidTap(indexPath.row, viewModel[indexPath.row].state)
            self.reloadTableView()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension MainTaskViewController {
    private func retrieveTask(by tableView: UITableView) -> [TaskViewModel]? {
        switch tableView {
        case taskStandbyTableView:
            return fetchedViewModels?.filter { $0.state == .todo }
        case taskInProgressTableView:
            return fetchedViewModels?.filter { $0.state == .doing }
        case taskFinishedTableView:
            return fetchedViewModels?.filter { $0.state == .done }
        default:
            return nil
        }
    }
    
    private func setup() {
        configureNavigationBar()
        configureTableView()
        configureUI()
        configureLongPressGestureRecognizer()
    }
    
    private func reloadTableView() {
        [self.taskStandbyTableView, self.taskInProgressTableView, self.taskFinishedTableView].forEach {
            $0.reloadData()
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(showCreateViewController)
        )
    }
    
    @objc private func showCreateViewController() {
        mainTaskService.input.addButtonDidTap()
    }
    
    private func configureTableView() {
        [taskStandbyTableView, taskInProgressTableView, taskFinishedTableView].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private func configureUI() {
        [taskStandbyTableView, taskInProgressTableView, taskFinishedTableView].forEach {
            entireProjectStackView.addArrangedSubview($0)
        }
        
        view.addSubview(entireProjectStackView)
        
        NSLayoutConstraint.activate([
            entireProjectStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            entireProjectStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            entireProjectStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            entireProjectStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureLongPressGestureRecognizer() {
        let longPressOnTodo = UILongPressGestureRecognizer(target: self, action: #selector(processLongPressOnTodo(_:)))
        let longPressOnDoing = UILongPressGestureRecognizer(target: self, action: #selector(processLongPressOnDoing(_:)))
        let longPressOnDone = UILongPressGestureRecognizer(target: self, action: #selector(processLongPressOnDone(_:)))
        
        taskStandbyTableView.addGestureRecognizer(longPressOnTodo)
        taskInProgressTableView.addGestureRecognizer(longPressOnDoing)
        taskFinishedTableView.addGestureRecognizer(longPressOnDone)
    }
    
    private func longPressToMove(gesture: UILongPressGestureRecognizer, tableView: UITableView, from: TaskState, to: [TaskState]) {
        guard let indexPath = tableView.indexPathForRow(at: gesture.location(in: tableView)),
              let viewModel = retrieveTask(by: tableView)?[indexPath.row] else {
            return
        }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let alertActions: [UIAlertAction] = mainTaskService.input.moveTask(viewModel, from, to)
        
        alertActions.forEach { alertController.addAction($0) }
        alertController.popoverPresentationController?.sourceView = tableView.cellForRow(at: indexPath)
        
        present(alertController, animated: true)
    }
    
    @objc private func processLongPressOnTodo(_ sender: UILongPressGestureRecognizer) {
        longPressToMove(gesture: sender, tableView: taskStandbyTableView, from: .todo, to: [.doing, .done])
    }
    
    @objc private func processLongPressOnDoing(_ sender: UILongPressGestureRecognizer) {
        longPressToMove(gesture: sender, tableView: taskInProgressTableView, from: .doing, to: [.todo, .done])
    }
    
    @objc private func processLongPressOnDone(_ sender: UILongPressGestureRecognizer) {
        longPressToMove(gesture: sender, tableView: taskFinishedTableView, from: .done, to: [.todo, .doing])
    }
}

extension MainTaskViewController: CreateTaskViewControllerDelegate {
    func doneButtonDidTap(_ viewModel: TaskViewModel) {
        mainTaskService.input.doneButtonDidTap(viewModel)
    }
}

extension MainTaskViewController: EditTaskViewControllerDelegate {
    func doneButtonDidTap(viewModel: TaskViewModel, changedViewModel: TaskViewModel) {
        let newTask = Task.init(viewModel: changedViewModel)
        guard let index = fetchedViewModels?.firstIndex(of: viewModel) else {
            return
        }
        
        mainTaskService.taskUseCase.update(task: newTask)
        fetchedViewModels?.remove(at: index)
        fetchedViewModels?.insert(changedViewModel, at: index)
        reloadTableView()
    }
}
