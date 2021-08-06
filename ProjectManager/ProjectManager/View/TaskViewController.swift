//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

final class TaskViewController: UIViewController {
    private let todoHeadView = TaskHeadView(classification: Classification.todo.name.uppercased())
    private let doingHeadView = TaskHeadView(classification: Classification.doing.name.uppercased())
    private let doneHeadView = TaskHeadView(classification: Classification.done.name.uppercased())

    private let headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private let todoTableView = TaskTableView(status: Classification.todo.name)
    private let doingTableView = TaskTableView(status: Classification.doing.name)
    private let doneTableView = TaskTableView(status: Classification.done.name)

    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setMainView()
        setHeadView()
        setTableView()
    }

    private func setNavigation() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(didTapAddButton))
    }

    private func setMainView() {
        self.view.addSubview(headStackView)
        self.view.addSubview(tableStackView)
        self.view.backgroundColor = .systemBackground
    }

    private func setHeadView() {
        countHeadViewNumber()

        [todoHeadView, doingHeadView, doneHeadView].forEach { headView in
            headStackView.addArrangedSubview(headView)
        }

        headStackView.snp.makeConstraints { stackView in
            stackView.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

    }

    private func setTableView() {
        [todoTableView, doingTableView, doneTableView].forEach { tableView in
            self.tableStackView.addArrangedSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.dragInteractionEnabled = true
            tableView.dragDelegate = self
            tableView.dropDelegate = self
        }

        tableStackView.snp.makeConstraints { stackView in
            stackView.top.equalTo(headStackView.snp.bottom)
            stackView.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func switchClassification(classification: String) -> TaskTableView {
        switch classification {
        case Classification.todo.name:
            return todoTableView
        case Classification.doing.name:
            return doingTableView
        default:
            return doneTableView
        }
    }

    @objc func didTapAddButton() {
        let detailView = TaskDetailView(delegate: self,
                                        mode: .add,
                                        index: 0,
                                        classification: Classification.todo.name)
        detailView.modalPresentationStyle = .formSheet
        present(UINavigationController(rootViewController: detailView),
                animated: true,
                completion: nil)
    }
}

protocol TaskViewControllerDelegate {
    func createTodoTask(task: Task, index: Int)
    func updateTask(task: Task, index: Int)
    func deleteTask(index: Int, status: String)
    func countHeadViewNumber()
}

// MARK: - TaskViewController Delegate
extension TaskViewController: TaskViewControllerDelegate {
    func createTodoTask(task: Task, index: Int) {
        todoTableView.createTask(task: task, index: index)
        todoTableView.reloadData()
    }

    func updateTask(task: Task, index: Int) {
        let tableView = switchClassification(classification: task.classification)
        tableView.updateTask(index: index, task: task)
        tableView.reloadData()
    }

    func deleteTask(index: Int, status: String) {
        let tableView = switchClassification(classification: status)
        tableView.deleteTask(index: index)
        tableView.reloadData()
    }

    func countHeadViewNumber() {
        todoHeadView.setCountNumberLabelText(countNumber: todoTableView.countTasks().description)
        doingHeadView.setCountNumberLabelText(countNumber: doingTableView.countTasks().description)
        doneHeadView.setCountNumberLabelText(countNumber: doneTableView.countTasks().description)
    }
}

// MARK: - TableView Delegate
extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableView = tableView as? TaskTableView else { return }
        let classification: String = tableView.readTask(index: indexPath.row).classification
        let detailView = TaskDetailView(delegate: self,
                                        mode: .edit,
                                        index: indexPath.row,
                                        classification: classification)

        detailView.setTextAndDate(task: tableView.readTask(index: indexPath.row))
        present(UINavigationController(rootViewController: detailView),
                animated: true,
                completion: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let tableView = tableView as? TaskTableView else { return }
        if editingStyle == .delete {
            tableView.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - TableView DataSource
extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let taskTableView = tableView as? TaskTableView else { return 0 }
        return taskTableView.countTasks()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? TaskTableViewCell,
              let taskTableView = tableView as? TaskTableView else { return UITableViewCell()}

        let task = taskTableView.readTask(index: indexPath.row)
        cell.setLabelText(title: task.title, context: task.context, deadline: task.deadline)
        return cell
    }
}

// MARK: - TableView Drag Delegate
extension TaskViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let tableView = tableView as? TaskTableView else { return [] }
        let task = tableView.readTask(index: indexPath.row)
        let itemProvider = NSItemProvider(object: task)

        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = tableView.readTask(index: indexPath.row)
        session.localContext = DragSessionLocalContext(originIndexPath: indexPath)

        return [dragItem]
    }

    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let tableView = tableView as? TaskTableView,
              let localContext = session.localContext as? DragSessionLocalContext,
              localContext.didDragDropCompleted == true else { return }

        if !localContext.isReordering {
            tableView.deleteTask(index: localContext.originIndexPath.row)
            tableView.deleteRows(at: [localContext.originIndexPath], with: .automatic)
        }

        countHeadViewNumber()
    }
}

// MARK: - TableView Drop Delegate
extension TaskViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let tableView = tableView as? TaskTableView,
              let localContext = coordinator.session.localDragSession?.localContext as? DragSessionLocalContext,
              let item = coordinator.items.first,
              let dragTask = item.dragItem.localObject as? Task else { return }

        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(row: 0, section: 0)
        let didMovedFromSameTable = item.sourceIndexPath != nil

        if didMovedFromSameTable {
            localContext.isReordering = true

            tableView.swapAt(from: localContext.originIndexPath.row, to: destinationIndexPath.row)
        } else {
            tableView.createTask(task: dragTask, index: destinationIndexPath.row)

            countHeadViewNumber()
            dragTask.classification = tableView.classification
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
        }

        switch coordinator.proposal.operation {
        case .move:
            coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
            localContext.didDragDropCompleted = true
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
