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
    private let taskViewModel = TaskViewModel()
    
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
        
        setup()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath)
                as? TaskListCell,
              let task = retrieveTask(by: tableView) else {
            return UITableViewCell()
        }
        
        cell.configureUI(data: task[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProjectHeaderView") as? TaskHeaderView else {
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
        
        showEditViewController(with: task[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self = self,
                  let task = self.retrieveTask(by: tableView) else {
                return
            }
            
            self.taskViewModel.delete(data: task[indexPath.row])
            self.reloadTableView()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension MainTaskViewController {
    func retrieveTask(by tableView: UITableView) -> [TaskModelDTO]? {
        switch tableView {
        case taskStandbyTableView:
            return taskViewModel.fetch().filter { $0.state == .todo }
        case taskInProgressTableView:
            return taskViewModel.fetch().filter { $0.state == .doing }
        case taskFinishedTableView:
            return taskViewModel.fetch().filter { $0.state == .done }
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "EF_Diary", size: 20) as Any]
        navigationController?.navigationBar.backgroundColor = UIColor(red: 255/256, green: 183/256, blue: 195/256, alpha: 1)
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(showCreateViewController)
        )
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
            entireProjectStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            entireProjectStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            entireProjectStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            entireProjectStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func configureLongPressGestureRecognizer() {
        let longPressOnTodo = UILongPressGestureRecognizer(
            target: self,
            action: #selector(processLongPressOnTodo(_:))
        )
        let longPressOnDoing = UILongPressGestureRecognizer(
            target: self,
            action: #selector(processLongPressOnDoing(_:))
        )
        let longPressOnDone = UILongPressGestureRecognizer(
            target: self,
            action: #selector(processLongPressOnDone(_:))
        )
        
        taskStandbyTableView.addGestureRecognizer(longPressOnTodo)
        taskInProgressTableView.addGestureRecognizer(longPressOnDoing)
        taskFinishedTableView.addGestureRecognizer(longPressOnDone)
    }
    
    @objc private func processLongPressOnTodo(_ sender: UILongPressGestureRecognizer) {
        move(from: .todo, to: [.doing, .done], gesture: sender, tableView: taskStandbyTableView)
    }
    
    @objc private func processLongPressOnDoing(_ sender: UILongPressGestureRecognizer) {
        move(from: .doing, to: [.todo, .done], gesture: sender, tableView: taskInProgressTableView)
    }
    
    @objc private func processLongPressOnDone(_ sender: UILongPressGestureRecognizer) {
        move(from: .done, to: [.todo, .doing], gesture: sender, tableView: taskFinishedTableView)
    }
    
    private func move(from current: ProjectState,
                      to future: [ProjectState],
                      gesture: UILongPressGestureRecognizer,
                      tableView: UITableView) {
        guard let indexPath = tableView.indexPathForRow(at: gesture.location(in: tableView)) else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let alertActions: [UIAlertAction] = self.getAlertAction(current: current,
                                                                first: future[0],
                                                                second: future[1],
                                                                indexPath: indexPath,
                                                                tableView: tableView)
        
        alertActions.forEach { alertController.addAction($0) }
        alertController.popoverPresentationController?.sourceView = tableView.cellForRow(at: indexPath)
        
        present(alertController, animated: true)
    }
    
    private func getAlertAction(current: ProjectState,
                                first: ProjectState,
                                second: ProjectState,
                                indexPath: IndexPath,
                                tableView: UITableView) -> [UIAlertAction] {
        let firstAction = UIAlertAction(title: first.destination, style: .default) { [weak self] _ in
            guard let self = self,
                  let movedData = self.retrieveTask(by: tableView)?[indexPath.row] else {
                return
            }
            
            self.taskViewModel.changeState(data: movedData, to: first)
            self.reloadTableView()
        }
        
        let secondAction = UIAlertAction(title: second.destination, style: .default) { _ in
            guard let movedData =  self.retrieveTask(by: tableView)?[indexPath.row] else {
                return
            }
            
            self.taskViewModel.changeState(data: movedData, to: second)
            self.reloadTableView()
        }
        
        return [firstAction, secondAction]
    }
    
    private func showEditViewController(with model: TaskModelDTO) {
        let editTaskViewController = EditTaskViewController()
        let editTaskNavigationViewController = UINavigationController(rootViewController: editTaskViewController)
        editTaskNavigationViewController.modalPresentationStyle = .formSheet
        editTaskViewController.delegate = self
        editTaskViewController.configureModel(model)

        present(editTaskNavigationViewController, animated: true, completion: nil)
    }

    @objc private func showCreateViewController() {
        let createTaskViewController = CreateTaskViewController()
        let createTaskNavigationViewController = UINavigationController(rootViewController: createTaskViewController)
        createTaskNavigationViewController.modalPresentationStyle = .formSheet
        createTaskViewController.delegate = self

        present(createTaskNavigationViewController, animated: true, completion: nil)
    }
}

extension MainTaskViewController: MainTaskViewControllerDelegate {
    func didFinishEditData(content: TaskModelDTO) {
        taskViewModel.update(data: content)
        reloadTableView()
    }
    
    func didFinishSaveData(content: TaskModelDTO) {
        taskViewModel.insertContents(data: content)
        reloadTableView()
    }
}

