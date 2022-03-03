//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

// MARK: - Properties

    private var todoList = [[Todo]]()

    lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(
            frame: CGRect(
                x: MainVCConstraint.navigationBarStartPoint,
                y: MainVCConstraint.navigationBarStartPoint,
                width: self.view.frame.size.width,
                height: MainVCConstraint.navigationBarHeight
            )
        )
        let navigationItem = UINavigationItem(title: MainVCScript.title)

        navigationBar.setItems([navigationItem], animated: false)

        return navigationBar
    }()

    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = MainVCConstraint.stackViewSpace
        stackView.distribution = .fillEqually
        stackView.backgroundColor = MainVCColor.stackViewSpaceColor

        return stackView
    }()

    let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = 0
        tableView.backgroundColor = MainVCColor.tableViewBackgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = 1
        tableView.backgroundColor = MainVCColor.tableViewBackgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = 2
        tableView.backgroundColor = MainVCColor.tableViewBackgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let dataProvider = DataProvider()

// MARK: - Override Method(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpController()
    }

// MARK: - SetUp Controller

        private func setUpController() {
            self.observeUpdate()
            self.setUpView()
            self.configureNavigationBar()
            self.configureStackView()
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

    private func setUpView() {
        self.view.backgroundColor = MainVCColor.viewBackgroundColor
    }

    private func configureNavigationBar() {
        self.view.addSubview(self.navigationBar)
    }

    private func configureStackView() {
        self.view.addSubview(self.stackView)
        self.addTableViewsToStackView()
        self.setStackViewConstraints()
    }

    private func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: MainVCConstraint.stackViewTopAnchor
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
}

// MARK: - Magic Numbers

private enum MainVCColor {

    static let viewBackgroundColor: UIColor = .white
    static let stackViewSpaceColor: UIColor = .systemGray3
    static let tableViewBackgroundColor: UIColor = .systemGray6
}

private enum MainVCScript {
    static let title = "Project Manager"
}

private enum MainVCConstraint {
    static let navigationBarStartPoint: CGFloat = 0
    static let navigationBarHeight: CGFloat = 60
    static let stackViewSpace: CGFloat = 10
    static let stackViewTopAnchor: CGFloat = 26
}
