//
//  ProjectManager - MainTaskViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainTaskViewController: UIViewController {
    let taskTableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let taskInWaitingTableView = TaskTableView(state: .waiting)
    let taskInProgressTableView = TaskTableView(state: .progress)
    let taskInDoneTableView = TaskTableView(state: .done)
    
    private var taskListViewModel: TaskViewModel
    
    init(taskListViewModel: TaskViewModel) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskListViewModel.didLoaded()
    }
    
    private func configureTaskListViewModel() {
        // TODO: - ViewModel 셋업
        taskListViewModel.taskDidCreated = { [weak self] in
            guard let self = self else {
                return
            }
            self.taskInWaitingTableView.reloadData()
        }
        
        taskListViewModel.taskDidDeleted = { [weak self] (index, state) in
            guard let self = self else {
                return
            }
            
            let indexPath = IndexPath(row: index, section: 0)
            
            switch state {
            case .waiting:
                self.taskInWaitingTableView.deleteRows(at: [indexPath], with: .fade)
            case .progress:
                self.taskInProgressTableView.deleteRows(at: [indexPath], with: .fade)
            case .done:
                self.taskInDoneTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        taskListViewModel.taskDidChanged = { [weak self] (index, state) in
            guard let self = self else {
                return
            }
            
            let indexPath = IndexPath(row: index, section: 0)
            
            switch state {
            case .waiting:
                self.taskInWaitingTableView.reloadRows(at: [indexPath], with: .fade)
            case .progress:
                self.taskInProgressTableView.reloadRows(at: [indexPath], with: .fade)
            case .done:
                self.taskInDoneTableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
    
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
    
    @objc func addTask() {
        let taskManageViewController = TaskManageViewController(manageType: .add, taskListViewModel: taskListViewModel)
        let taskManageNavigationViewController = UINavigationController(rootViewController: taskManageViewController)
        taskManageNavigationViewController.modalPresentationStyle = .formSheet
        
        self.present(taskManageNavigationViewController, animated: true, completion: nil)
    }
}

extension MainTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let taskTableView = tableView as? TaskTableView else {
            return .zero
        }
        
        return taskListViewModel.count(of: taskTableView.state)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskTableViewCell.self, for: indexPath)
        guard let taskTableView = tableView as? TaskTableView,
              let task = taskListViewModel.task(at: indexPath.row, from: taskTableView.state) else {
            return TaskTableViewCell()
        }
        
        cell.configureCell(title: task.title, description: task.description, deadline: task.deadline, state: taskTableView.state)
        
        return cell
    }
}

extension MainTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let state = (tableView as? TaskTableView)?.state,
              let selectedTask = taskListViewModel.task(at: indexPath.row, from: state) else {
            return
        }
                
        let taskManageViewController = TaskManageViewController(manageType: .detail, taskListViewModel: taskListViewModel, task: selectedTask, selectedIndex: indexPath.row)
        let taskManageNavigationViewController = UINavigationController(rootViewController: taskManageViewController)
        taskManageNavigationViewController.modalPresentationStyle = .formSheet
        
        self.present(taskManageNavigationViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            guard let state = (tableView as? TaskTableView)?.state else {
                return
            }
            
            self.taskListViewModel.deleteRow(at: indexPath.row, from: state)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}
