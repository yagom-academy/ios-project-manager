//
//  ProjectManager - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate {
    var todoViewModel = ToDoViewModel()
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
        setupLongPressRecognizer()
        todoViewModel.todoOnUpdated = { [weak self] in
            self?.toDoTableView.reloadData()
            self?.doingTableView.reloadData()
            self?.doneTableView.reloadData()
        }
        todoViewModel.reload()
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
        toDoTableView.backgroundColor = .systemGray6
        doingTableView.backgroundColor = .systemGray6
        doneTableView.backgroundColor = .systemGray6
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
    
    private func setupLongPressRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let toDoTouchPoint = sender.location(in: self.toDoTableView)
            let doingTouchPoint = sender.location(in: self.doingTableView)
            let doneTouchPoint = sender.location(in: self.doneTableView)

            if let toDoIndexPath = toDoTableView.indexPathForRow(at: toDoTouchPoint) {
                print(toDoIndexPath)
                showActionSheet(firstSeleteTitle: "Move to DOING", secondSeleteTitle: "Move to DONE", tableViewSection: toDoTableView, indexPath: toDoIndexPath)
            }
            if let doingIndexPath = doingTableView.indexPathForRow(at: doingTouchPoint) {
                print(doingIndexPath)
                showActionSheet(firstSeleteTitle: "Move to TODO", secondSeleteTitle: "Move to DONE", tableViewSection: doingTableView, indexPath: doingIndexPath)
            }
            if let doneIndexPath = doneTableView.indexPathForRow(at: doneTouchPoint) {
                print(doneIndexPath)
                showActionSheet(firstSeleteTitle: "Move to TODO", secondSeleteTitle: "Move to DOING", tableViewSection: doneTableView, indexPath: doneIndexPath)
            }
        }
    }
    
    func showActionSheet(
        firstSeleteTitle: String,
        secondSeleteTitle: String,
        tableViewSection: UITableView,
        indexPath: IndexPath
    ) {
        let firstAction = UIAlertAction(title: firstSeleteTitle, style: .default)
        let secondAction = UIAlertAction(title: secondSeleteTitle, style: .default)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let popover = alert.popoverPresentationController
        popover?.sourceView = tableViewSection
        
        let rowRect = tableViewSection.rectForRow(at: indexPath)
        let rowCenterRect = rowRect.offsetBy(dx: 0, dy: -rowRect.height/2)
        popover?.sourceRect = rowCenterRect
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        self.present(alert, animated: true)
    }

    
    @objc func showEditView() {
        let editView = EditViewController()
        editView.delegate = self
        let modalView = UINavigationController(rootViewController: editView)
        modalView.modalPresentationStyle = .automatic
        self.present(modalView, animated: true)
    }
}

extension MainViewController: EditViewDelegate {
    func editViewDidDismiss(todo: ToDoInfomation) {
        todoViewModel.save(with: todo)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return todoViewModel.todos.count
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
        let todo = todoViewModel.todos[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteTarget = todoViewModel.todos[indexPath.row]
        let delete = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.todoViewModel.delete(with: deleteTarget)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
