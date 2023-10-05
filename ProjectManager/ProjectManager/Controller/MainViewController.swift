//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private lazy var todoListViewController: ListViewController = {
        let listViewController = ListViewController(listKind: .todo)
        
        listViewController.delegate = self
        return listViewController
    }()
    
    private lazy var doingListViewController: ListViewController = {
        let listViewController = ListViewController(listKind: .doing)
        
        listViewController.delegate = self
        return listViewController
    }()
    
    private lazy var doneListViewController: ListViewController = {
        let listViewController = ListViewController(listKind: .done)
        
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
        
        let rightAddButtonAction: UIAction = .init {
            action in self.didTappedRightAddButton()
        }
        
        navigationItem.rightBarButtonItem = .init(systemItem: .add, primaryAction: rightAddButtonAction)
    }
    
    private func reloadTaskListViewControllers() {
        var todoList = [Task]()
        var doingList = [Task]()
        var doneList = [Task]()
        
        for task in taskList {
            switch task.listKind {
            case .todo:
                todoList.append(task)
            case .doing:
                doingList.append(task)
            case .done:
                doneList.append(task)
            }
        }
        
        todoListViewController.setUpDiffableDataSourceSanpShot(taskList: todoList)
        doingListViewController.setUpDiffableDataSourceSanpShot(taskList: doingList)
        doneListViewController.setUpDiffableDataSourceSanpShot(taskList: doneList)
    }
}

// MARK: - Button Action
extension MainViewController {
    private func didTappedRightAddButton() {
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
    func didTappedRightDoneButton(task: Task) {
        taskList.append(task)
    }
}

// MARK: - ListViewController Delegate
extension MainViewController: ListViewControllerDelegate {
    func didTappedRightDoneButtonForUpdate(updateTask: Task) {
        let updatedTaskList = taskList.map {
            if $0.id == updateTask.id {
                var task = $0
                
                task.title = updateTask.title
                task.description = updateTask.description
                task.deadline = updateTask.deadline
                return task
            }
            
            return $0
        }
        
        taskList = updatedTaskList
    }
}
