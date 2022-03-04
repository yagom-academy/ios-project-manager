//
//  ProjectManager - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate {
    private let taskStackView = UIStackView()
    private let toDoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()
    let dataManager = TestDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTaskStackView()
        setupConstraint()
        setupTableView()
    }

    private func setupNavigation() {
        navigationItem.title = "Project Manager"
        let addButtonImage = UIImage(systemName: "plus")
        let rightButton = UIBarButtonItem(
          image: addButtonImage,
          style: .done,
          target: self,
          action: #selector(showEditView)
        )
        navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    private func setupTableView() {
        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
        toDoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        toDoTableView.register(
            TaskCell.self,
            forCellReuseIdentifier: "TaskCell"
        )
        doingTableView.register(
            TaskCell.self,
            forCellReuseIdentifier: "TaskCell"
        )
        doneTableView.register(
            TaskCell.self,
            forCellReuseIdentifier: "TaskCell"
        )
    }

    private func setupTaskStackView() {
        view.addSubview(taskStackView)
        taskStackView.addArrangedSubview(toDoTableView)
        taskStackView.addArrangedSubview(doingTableView)
        taskStackView.addArrangedSubview(doneTableView)

        taskStackView.axis = .horizontal
        taskStackView.distribution = .fillEqually
        taskStackView.backgroundColor = .lightGray
        taskStackView.spacing = 10
    }

    private func setupConstraint() {
        taskStackView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            taskStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            taskStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            taskStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    @objc func showEditView() {
        let editView = UINavigationController(rootViewController: EditViewController())
        editView.modalPresentationStyle = .automatic
        self.present(editView, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return dataManager.dataList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
          withIdentifier: "TaskCell",
          for: indexPath
        ) as? TaskCell else {
            return UITableViewCell()
        }

        cell.configure(with: indexPath.row)
        
        return cell
    }
}
