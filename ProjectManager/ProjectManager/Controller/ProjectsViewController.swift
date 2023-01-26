//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectsViewController: UIViewController {

    private let todoViewController = TaskListViewController(type: .todo)
    private let doingViewController = TaskListViewController(type: .doing)
    private let doneViewController = TaskListViewController(type: .done)
    
    enum Constant {
        static let navigationTitle = "Project Manager"
        static let stackViewSpacing: CGFloat = 10
        static let preferredAddViewContentSize: CGFloat = 650
    }

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = Constant.stackViewSpacing
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationItem()
    }

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        configureChildViewControllers()
        configureConstraints()
    }

    private func configureChildViewControllers() {
        todoViewController.willMove(toParent: self)
        doingViewController.willMove(toParent: self)
        doneViewController.willMove(toParent: self)
        
        todoViewController.moveDelegate = self
        todoViewController.editDelgate = self
        doingViewController.moveDelegate = self
        doingViewController.editDelgate = self
        doneViewController.moveDelegate = self
        doneViewController.editDelgate = self
        
        stackView.addArrangedSubview(todoViewController.view)
        stackView.addArrangedSubview(doingViewController.view)
        stackView.addArrangedSubview(doneViewController.view)

        self.addChild(todoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)

        todoViewController.didMove(toParent: self)
        doingViewController.didMove(toParent: self)
        doneViewController.didMove(toParent: self)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureNavigationItem() {
        navigationItem.title = Constant.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddProjectView))
    }

    @objc private func showAddProjectView() {
        let addProjectViewController = AddProjectViewController()
        addProjectViewController.delegate = self
        let secondNavigationController = UINavigationController(rootViewController: addProjectViewController)
        secondNavigationController.modalPresentationStyle = .formSheet
        self.present(secondNavigationController, animated: true)
    }
    
    private func updateTodoTask(with task: Task) {
        todoViewController.filteredTasks.append(task)
    }
}

extension ProjectsViewController: TaskAddDelegate, TaskMoveDelegate, TaskEditDelegate {
    func taskDidEdited(to newTask: Task, from task: Task) {
        print("여기까지옴")
        switch task.status {
        case .todo:
            todoViewController.deleteTask(task)
            todoViewController.filteredTasks.append(newTask)
        case .done:
            doneViewController.deleteTask(task)
            doneViewController.filteredTasks.append(newTask)
        case .doing:
            doingViewController.deleteTask(task)
            doingViewController.filteredTasks.append(newTask)
        }
    }

    func taskDidAdded(_ task: Task) {
        updateTodoTask(with: task)
    }
    
    func taskDidMoved(_ task: Task, from currentStatus: TaskStatus, to futureStatus: TaskStatus) {
        switch currentStatus {
        case .todo:
            todoViewController.deleteTask(task)
        case .done:
            doneViewController.deleteTask(task)
        case .doing:
            doingViewController.deleteTask(task)
        }
        
        let newTask = Task(id: task.id, title: task.title, description: task.description, date: task.date, status: futureStatus)
        switch futureStatus {
        case .todo:
            todoViewController.filteredTasks.append(newTask)
        case .done:
            doneViewController.filteredTasks.append(newTask)
        case .doing:
            doingViewController.filteredTasks.append(newTask)
        }
    }
}
