//
//  ProjectManager - ProjectListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectListViewController: UIViewController {
    // MARK: Properties
    private let projectManager: ProjectManager
    private var todoList: [Project] = [] {
        didSet {
            todoViewController.update(with: todoList)
        }
    }

    private var doingList: [Project] = [] {
        didSet {
            doingViewController.update(with: doingList)
        }
    }

    private var doneList: [Project] = [] {
        didSet {
            doneViewController.update(with: doneList)
        }
    }

    private lazy var todoViewController = ProjectTableViewController(status: .todo,
                                                                tableView: ProjectTableView(),
                                                                delegate: self)
    private lazy var doingViewController = ProjectTableViewController(status: .doing,
                                                                 tableView: ProjectTableView(),
                                                                 delegate: self)
    private lazy var doneViewController = ProjectTableViewController(status: .done,
                                                                tableView: ProjectTableView(),
                                                                delegate: self)

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        createDummyProject()
        addChildViewControllers()
        configureView()
        configureConstraints()
        updateChildViewController()
    }

    init(projectManager: ProjectManager) {
        self.projectManager = projectManager
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func presentProjectViewController() {
        let project = Project(status: .todo, title: "제목없음", description: " ", dueDate: Date())
        let projectViewController = ProjectViewController(with: project, mode: .add, delegate: self)

        present(UINavigationController(rootViewController: projectViewController), animated: false)
    }

    private func makeRightNavigationBarButton() -> UIBarButtonItem {
        let touchUpAddButtonAction = UIAction { [weak self] _ in
            self?.presentProjectViewController()
        }

        let addButton = UIBarButtonItem(systemItem: .add, primaryAction: touchUpAddButtonAction)

        return addButton
    }

    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = makeRightNavigationBarButton()
    }

    private func createDummyProject() {
        DummyProjects.projects.forEach {
            projectManager.create(project: $0)
        }

        updateProjectList()
    }

    private func addChildViewControllers() {
        [todoViewController, doingViewController, doneViewController].forEach {
            addChild($0)
        }
    }

    private func configureView() {
        view.addSubview(stackView)

        children.forEach {
            stackView.addArrangedSubview($0.view)
        }
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func updateChildViewController() {
        children.forEach {
            guard let childViewController = $0 as? ProjectTableViewController else {
                return
            }

            switch childViewController.status {
            case .todo:
                childViewController.update(with: todoList)
            case .doing:
                childViewController.update(with: doingList)
            case .done:
                childViewController.update(with: doneList)
            }
        }
    }

    private func updateProjectList() {
        if todoList != projectManager.read(status: .todo) {
            todoList = projectManager.read(status: .todo)
        }

        if doingList != projectManager.read(status: .doing) {
            doingList = projectManager.read(status: .doing)
        }

        if doneList != projectManager.read(status: .done) {
            doneList = projectManager.read(status: .done)
        }
    }
}

// MARK: Project Delegate
extension ProjectListViewController: ProjectDelegate {
    func create(project: Project) {
        projectManager.create(project: project)
        updateProjectList()
    }

    func update(project: Project) {
        projectManager.update(project: project)
        updateProjectList()
    }

    func delete(project: Project) {
        projectManager.delete(project: project)
        updateProjectList()
    }
}
