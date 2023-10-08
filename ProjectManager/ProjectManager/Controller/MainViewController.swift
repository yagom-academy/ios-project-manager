//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private lazy var todoListViewController: ListViewController = {
        let listViewController = ListViewController(taskStatus: .todo)
        
        listViewController.delegate = self
        return listViewController
    }()
    
    private lazy var doingListViewController: ListViewController = {
        let listViewController = ListViewController(taskStatus: .doing)
        
        listViewController.delegate = self
        return listViewController
    }()
    
    private lazy var doneListViewController: ListViewController = {
        let listViewController = ListViewController(taskStatus: .done)
        
        listViewController.delegate = self
        return listViewController
    }()

    private var taskList: [Task] = [] {
        didSet {
            reloadTaskListViewControllers()
        }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let useCase: MainViewControllerUseCaseType
    
    init(useCase: MainViewControllerUseCaseType) {
        self.useCase = useCase
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpConstraints()
        setUpViewController()
    }
    
    private func configureUI() {
        [todoListViewController, doingListViewController, doneListViewController].forEach {
            stackView.addArrangedSubview($0.view)
        }
        
        view.addSubview(stackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Project Manager"
        
        let addButtonAction: UIAction = .init {
            action in self.didTappedAddButton()
        }
        
        navigationItem.rightBarButtonItem = .init(systemItem: .add, primaryAction: addButtonAction)
    }
    
    private func reloadTaskListViewControllers() {
        var todoList = [Task]()
        var doingList = [Task]()
        var doneList = [Task]()
        
        for task in taskList {
            switch task.taskStatus {
            case .todo:
                todoList.append(task)
            case .doing:
                doingList.append(task)
            case .done:
                doneList.append(task)
            }
        }
        
        todoListViewController.reloadTaskList(taskList: todoList)
        doingListViewController.reloadTaskList(taskList: doingList)
        doneListViewController.reloadTaskList(taskList: doneList)
    }
}

// MARK: - Button Action
extension MainViewController {
    private func didTappedAddButton() {
        let newTask = Task(title: "", description: "", deadline: 0.0)
        let taskViewController = TaskViewController(task: newTask, mode: .append)
        let navigationController = UINavigationController(rootViewController: taskViewController)
        
        taskViewController.delegate = self
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
    }
}

// MARK: - TaskViewController Delegate
extension MainViewController: TaskViewControllerDelegate {
    func didTappedDoneButton(task: Task) {
        taskList.append(task)
    }
}

// MARK: - ListViewController Delegate
extension MainViewController: ListViewControllerDelegate {
    func moveCell(moveToTaskStatus: TaskStatus, task: Task) {
        taskList = useCase.convertUpdatedTaskList(taskList: taskList,
                                                  updateTask: task,
                                                  moveToTaskStatus: moveToTaskStatus)
    }
    
    func didSwipedDeleteTask(deleteTask: Task) {
        for (index, task) in taskList.enumerated() {
            if task.id == deleteTask.id {
                taskList.remove(at: index)
                break
            }
        }
    }
    
    func didTappedDoneButtonForUpdate(updateTask: Task) {
        taskList = useCase.convertUpdatedTaskList(taskList: taskList,
                                                  updateTask: updateTask,
                                                  moveToTaskStatus: updateTask.taskStatus)
    }
}
