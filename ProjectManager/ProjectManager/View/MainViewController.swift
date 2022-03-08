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
        navigationItem.setRightBarButton(
            rightButton,
            animated: false
        )
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
            forCellReuseIdentifier: "TodoCell"
        )
        doingTableView.register(
            TaskCell.self,
            forCellReuseIdentifier: "DoingCell"
        )
        doneTableView.register(
            TaskCell.self,
            forCellReuseIdentifier: "DoneCell"
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
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPress(sender:))
        )
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func showEditView() {
        let editView = EditViewController()
        editView.delegate = self
        let modalView = UINavigationController(rootViewController: editView)
        modalView.modalPresentationStyle = .automatic
        self.present(modalView, animated: true)
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.taskStackView)
            let sectionSize = self.taskStackView.frame.width / 3
            if touchPoint.x < sectionSize {
                self.setupPopover(
                    tableView: toDoTableView,
                    touchYPoint: sender.location(in: toDoTableView)
                )
            } else if touchPoint.x < sectionSize * 2 {
                self.setupPopover(
                    tableView: doingTableView,
                    touchYPoint: sender.location(in: doingTableView)
                )
            } else {
                self.setupPopover(
                    tableView: doneTableView,
                    touchYPoint: sender.location(in: doneTableView)
                )
            }
        }
    }
    
    func setupPopover(
        tableView: UITableView,
        touchYPoint: CGPoint
    ) {
        let beforePosition: ToDoPosition
        let firstSelect: (String, ToDoPosition)
        let secondSelect: (String, ToDoPosition)
        guard let selectedIndexPath = tableView.indexPathForRow(at: touchYPoint) else {
            return
        }
        
        switch tableView {
        case toDoTableView:
            beforePosition = .ToDo
            firstSelect = ("Move to DOING", .Doing)
            secondSelect = ("Move to DONE", .Done)
        case doingTableView:
            beforePosition = .Doing
            firstSelect = ("Move to DONE", .Done)
            secondSelect = ("Move to TODO", .ToDo)
        case doneTableView:
            beforePosition = .Done
            firstSelect = ("Move to TODO", .ToDo)
            secondSelect = ("Move to DOING", .Doing)
        default: return
        }
        
        self.showPopover(
            firstSelectTitle: firstSelect.0,
            secondSelectTitle: secondSelect.0,
            tableView: tableView,
            indexPath: selectedIndexPath
        ) { _ in
            self.todoViewModel.changePosition(
                from: beforePosition,
                to: firstSelect.1,
                currentIndexPath: selectedIndexPath.row
            )
        } secoundHandler: { _ in
            self.todoViewModel.changePosition(
                from: beforePosition,
                to: secondSelect.1,
                currentIndexPath: selectedIndexPath.row
            )
        }
    }
    
    func showPopover(
        firstSelectTitle: String,
        secondSelectTitle: String,
        tableView: UITableView,
        indexPath: IndexPath,
        firstHandler: @escaping (UIAlertAction) -> Void,
        secoundHandler: @escaping (UIAlertAction) -> Void
    ) {
        let firstAction = UIAlertAction(
            title: firstSelectTitle,
            style: .default,
            handler: firstHandler
        )
        let secondAction = UIAlertAction(
            title: secondSelectTitle,
            style: .default,
            handler: secoundHandler
        )
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let popover = alert.popoverPresentationController
        popover?.sourceView = tableView
        
        let rowRect = tableView.rectForRow(at: indexPath)
        let rowCenterRect = rowRect.offsetBy(dx: 0, dy: -rowRect.height/2)
        popover?.sourceRect = rowCenterRect
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        self.present(alert, animated: true)
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
        if tableView == toDoTableView {
            return todoViewModel.todos.filter { $0.position == .ToDo }.count
        } else if tableView == doingTableView {
            return todoViewModel.todos.filter { $0.position == .Doing }.count
        } else {
            return todoViewModel.todos.filter { $0.position == .Done }.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cellIdentifier: String
        if tableView == toDoTableView {
            cellIdentifier = "TodoCell"
        } else if tableView == doingTableView {
            cellIdentifier = "DoingCell"
        } else {
            cellIdentifier = "DoneCell"
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        ) as? TaskCell else {
            return UITableViewCell()
        }
        
        let todo = todoViewModel.todos[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo: ToDoInfomation
        if tableView == toDoTableView {
            todo = todoViewModel.todos.filter{ $0.position == .ToDo }[indexPath.row]
        } else if tableView == doingTableView {
            todo = todoViewModel.todos.filter { $0.position == .Doing }[indexPath.row]
        } else {
            todo = todoViewModel.todos.filter { $0.position == .Done }[indexPath.row]
        }
        
        let editView = EditViewController()
        editView.configure(todo: todo)
        editView.delegate = self
        let modalView = UINavigationController(rootViewController: editView)
        modalView.modalPresentationStyle = .automatic
        self.present(modalView, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteTarget = todoViewModel.todos[indexPath.row]
        let delete = UIContextualAction(
            style: .normal,
            title: "Delete"
        ) { _, _, _ in
            self.todoViewModel.delete(with: deleteTarget)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
