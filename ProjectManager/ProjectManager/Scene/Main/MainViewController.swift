//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

// MARK: - Properties

    private var todoList = [[Todo]]() {
        didSet {
            DispatchQueue.main.async {
                self.reload()
            }
        }
    }

    private let dataProvider = DataProvider()

// MARK: - View Components

    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: MainVCScript.plusButtonImage)
        button.target = self
        button.action = #selector(plusButtonDidTap)

        return button
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = MainVCConstraint.stackViewSpace
        stackView.distribution = .fillEqually
        stackView.backgroundColor = MainVCColor.stackViewSpaceColor

        return stackView
    }()

    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = TodoSection.todo.rawValue
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }()

    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = TodoSection.doing.rawValue
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }()

    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = TodoSection.done.rawValue
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }()

// MARK: - Override Method(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpController()
    }

// MARK: - SetUp Controller

    private func setUpController() {
        self.observeUpdate()
        self.configureStackView()
        self.configureNavigationBar()
        self.setUpTableView()
    }

// MARK: - Observing Method(s)

    private func observeUpdate() {
        dataProvider.updated = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }

                self.todoList = self.dataProvider.updatedList()
            }
        }

        self.dataProvider.reload()
    }

// MARK: - Configure Views

    private func configureStackView() {
        self.view.addSubview(self.stackView)
        self.addTableViewsToStackView()
        self.setStackViewConstraints()
    }

    private func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }

    private func addTableViewsToStackView() {
        self.stackView.addArrangedSubview(todoTableView)
        self.stackView.addArrangedSubview(doingTableView)
        self.stackView.addArrangedSubview(doneTableView)
    }

// MARK: - Configure Navigation Bar

    private func configureNavigationBar() {
        self.title = MainVCScript.title
        self.navigationItem.rightBarButtonItem = self.plusButton
        self.setUpNavigationBarTintColor()
    }

    private func setUpNavigationBarTintColor() {
        self.navigationController?.navigationBar.barTintColor = MainVCColor.backgroundColor
    }

// MARK: - SetUp Table View

    private func setUpTableView() {
        self.setUpTableViewDataSource()
        self.setUpTableViewDelegate()

        self.registerTableViewCell()
    }

    private func setUpTableViewDataSource() {
        self.todoTableView.dataSource = self
        self.doingTableView.dataSource = self
        self.doneTableView.dataSource = self
    }

    private func setUpTableViewDelegate() {
        self.todoTableView.delegate = self
        self.doingTableView.delegate = self
        self.doneTableView.delegate = self
    }

    private func registerTableViewCell() {
        self.todoTableView.register(cellWithClass: MainTableViewCell.self)
        self.doingTableView.register(cellWithClass: MainTableViewCell.self)
        self.doneTableView.register(cellWithClass: MainTableViewCell.self)
    }

// MARK: - Reloading Method

    private func reload() {
        self.todoTableView.reloadData()
        self.doingTableView.reloadData()
        self.doneTableView.reloadData()
    }

// MARK: - Button Tap Actions

    @objc
    private func plusButtonDidTap() {
        let addTodoViewController = EditViewController()
        addTodoViewController.modalPresentationStyle = .formSheet
        addTodoViewController.modalTransitionStyle = .crossDissolve
        
        let navigationController = UINavigationController(
            rootViewController: addTodoViewController
        )

        self.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Table View DataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.todoList != [] else {
            return 0
        }

        return self.todoList[tableView.tag].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MainTableViewCell.self)
        cell.configureTodo(for: self.todoList[tableView.tag][indexPath.row])

        return cell
    }
}

// MARK: - Table View Delegate

extension MainViewController: UITableViewDelegate {
}

// MARK: - Magic Numbers

private enum MainVCColor {

    static let viewBackgroundColor: UIColor = .white
    static let stackViewSpaceColor: UIColor = .systemGray4
    static let backgroundColor: UIColor = .systemGray6
}

private enum MainVCScript {
    static let title = "Project Manager"
    static let plusButtonImage = "plus"
}

private enum MainVCConstraint {
    static let navigationBarStartPoint: CGFloat = 0
    static let navigationBarHeight: CGFloat = 60
    static let stackViewSpace: CGFloat = 10
    static let stackViewTopAnchor: CGFloat = 26
    static let estimatedCellHeight: CGFloat = 100
}
