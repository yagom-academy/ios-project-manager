//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let todoListViewController = ListViewController(listKind: .todo)
    private let doingListViewController = ListViewController(listKind: .doing)
    private let doneListViewController = ListViewController(listKind: .done)
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
        let newTask = Task(title: "", description: "", deadline: "")
        let taskViewController = TaskViewController(task: newTask)
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
