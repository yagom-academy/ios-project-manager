//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectsViewController: UIViewController {

    enum Constant {
        static let navigationTitle = "Project Manager"
        static let stackViewSpacing: CGFloat = 10
    }

    private let todoView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doingView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let doneView: ProjectListView = {
        let view = ProjectListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        stackView.addArrangedSubview(todoView)
        stackView.addArrangedSubview(doingView)
        stackView.addArrangedSubview(doneView)
        configureConstraints()
        todoView.setHeaderText(text: "TODO")
        doingView.setHeaderText(text: "DOING")
        doneView.setHeaderText(text: "DONE")
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
        self.present(addProjectViewController, animated: true)
    }
}
