//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

// MARK: - Properties

    private var todoList = [TodoTasks: [Todo]]() {
        didSet {
            self.reloadTableViewData()
        }
    }

    private let dataProvider = DataProvider()

// MARK: - View Components

    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: MainControllerImageName.plusButtonImage)
        button.target = self
        button.action = #selector(plusButtonDidTap)

        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = MainControllerConstraint.stackViewSpace
        stackView.distribution = .fillEqually
        stackView.backgroundColor = MainControllerColor.stackViewSpaceColor
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let sampleTableView: [UITableView] = TodoTasks.allCases.map { _ in
        let tableView = UITableView()
        tableView.backgroundColor = MainControllerColor.tableViewBackgroundColor
        tableView.estimatedRowHeight = MainControllerConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }

// MARK: - Modal View Controller

    private var editViewController: EditViewController = {
        let controller = EditViewController()
        controller.modalPresentationStyle = .formSheet
        controller.modalTransitionStyle = .crossDissolve

        return controller
    }()

// MARK: - Override Method(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpController()
    }

// MARK: - SetUp Controller

    private func setUpController() {
        self.observeDateProvider()
        self.configureStackView()
        self.configureNavigationBar()
        self.setUpTableView()
        self.setUpDelegate()
        self.setUpTableViewGesture()
    }

// MARK: - Observing Method

    private func observeDateProvider() {
        self.dataProvider.updated = { [weak self] in
            guard let self = self else {
                return
            }

            self.todoList = self.dataProvider.updatedList()
        }
        self.dataProvider.reload()
    }

// MARK: - Reload View

    func reloadTableViewData() {
        self.sampleTableView.forEach { tableView in
            tableView.reloadData()
        }
    }

// MARK: - Present Method(s)

    private func presentDeleteAlert(indexPath: IndexPath, in tableView: UITableView) {
        let alert = UIAlertController(
            title: MainControllerScript.deleteConfirmMessage, message: nil, preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: MainControllerScript.cancel, style: .cancel
        ) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.dismiss(animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(
            title: MainControllerScript.delete, style: .destructive
        ) { [weak self] _ in
            guard let self = self,
            let taskIndex = self.sampleTableView.firstIndex(of: tableView) else {
                return
            }
            let task = TodoTasks.getTask(taskIndex)
            guard let todosAtCertainTask = self.todoList[task] else {
                return
            }

            self.dataProvider.delete(todo: todosAtCertainTask[indexPath.row], at: task)
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func presentNavigationController() {
        self.editViewController.dataProvider = self.dataProvider
        let navigationController = UINavigationController(
            rootViewController: self.editViewController
        )

        self.present(navigationController, animated: true, completion: nil)
    }

    private func presentFailureAlert() {
        let alert = UIAlertController(
            title: MainControllerScript.failureMessage, message: nil, preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: MainControllerScript.confirm, style: .default
        ) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }

// MARK: - SetUp Delegate

    private func setUpDelegate() {
        self.editViewController.mainViewDelegate = self
    }

// MARK: - Configure Views

    private func configureStackView() {
        self.view.addSubview(self.stackView)
        self.addTableViewsToStackView()
        self.setStackViewConstraints()
    }

    private func addTableViewsToStackView() {
        self.sampleTableView.forEach { tableView in
            self.stackView.addArrangedSubview(tableView)
        }
    }

// MARK: - Configure View Constraints

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

// MARK: - Configure Navigation Bar

    private func configureNavigationBar() {
        self.title = MainControllerScript.title
        self.navigationItem.rightBarButtonItem = self.plusButton
        self.navigationController?.navigationBar.barTintColor = MainControllerColor.backgroundColor
    }

// MARK: - SetUp Table View

    private func setUpTableView() {
        self.registerTableViewHeader()
        self.registerTableViewCell()

        self.sampleTableView.forEach { tableView in
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    private func registerTableViewHeader() {
        self.sampleTableView.forEach { tableView in
            tableView.register(headerFooterViewClassWith: MainTableViewHeaderView.self)
        }
    }

    private func registerTableViewCell() {
        self.sampleTableView.forEach { tableView in
            tableView.register(cellWithClass: MainTableViewCell.self)
        }
    }

// MARK: - SetUp TableView LongPressGesture

    private func setUpTableViewGesture() {
        self.sampleTableView.enumerated().forEach { (index, tableView) in
            switch TodoTasks.getTask(index) {
            case .todo:
                self.addLongPressGestureRecognizer(
                    tableView: tableView,
                    selector: #selector(todoTableViewLongPressed(sender:))
                )
            case .doing:
                self.addLongPressGestureRecognizer(
                    tableView: tableView,
                    selector: #selector(doingTableViewLongPressed(sender:))
                )
            case .done:
                self.addLongPressGestureRecognizer(
                    tableView: tableView,
                    selector: #selector(doneTableViewLongPressed(sender:))
                )
            }
        }
    }

    private func addLongPressGestureRecognizer(tableView: UITableView, selector: Selector) {
        let longPress = UILongPressGestureRecognizer(target: self, action: selector)
        longPress.minimumPressDuration = MainVCMagicNumber.minimumPressDuration
        tableView.addGestureRecognizer(longPress)
    }

// MARK: - User Event Actions

    @objc
    private func plusButtonDidTap() {
        self.presentNavigationController()
        self.editViewController.resetToDefaultValue()
    }

    @objc
    private func todoTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        self.cellLongPressed(in: .todo, sender)
    }

    @objc
    private func doingTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        self.cellLongPressed(in: .doing, sender)
    }

    @objc
    private func doneTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        self.cellLongPressed(in: .done, sender)
    }

    private func cellLongPressed(in task: TodoTasks, _ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            do {
                let tableView = try self.matchTableView(to: task)
                let touchPoint = sender.location(in: tableView)
                self.presentTaskChangeActionSheet(at: touchPoint, in: tableView)
            } catch {
                self.presentFailureAlert()
            }
        }
    }

    private func presentTaskChangeActionSheet(
        at touchPoint: CGPoint, in tableView: UITableView
    ) {
        guard let indexPath = tableView.indexPathForRow(at: touchPoint),
              let taskIndex = self.sampleTableView.firstIndex(of: tableView)
        else {
            return
        }

        let selectedTask = TodoTasks.getTask(taskIndex)

        guard let todosAtSelectedTask = self.todoList[selectedTask] else {
            return
        }

        let selectedTodo = todosAtSelectedTask[indexPath.row]
        let actionSheet = self.setUpActionSheet(in: indexPath, of: tableView)

        self.setUpAlertActionWithOtherTasks(
            selectedTask: selectedTask, selectedTodo: selectedTodo, at: actionSheet
        )

        self.present(actionSheet, animated: true, completion: nil)
    }

// MARK: - SetUp ActionSheet

    private func setUpActionSheet(
        in indexPath: IndexPath,
        of tableView: UITableView
    ) -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.rectForRow(at: indexPath)

        return actionSheet
    }

    private func setUpAlertActionWithOtherTasks(
        selectedTask: TodoTasks, selectedTodo: Todo, at actionSheet: UIAlertController
    ) {
        let otherTasks = TodoTasks.allCases.filter { task in
            task != selectedTask
        }

        otherTasks.forEach { task in
            let action = UIAlertAction(
                title: MainControllerScript.moveTo + task.rawValue, style: .default
            ) { [weak self] _ in
                guard let self = self else {
                    return
                }

                self.dataProvider.editTask(todo: selectedTodo, at: task, originalTask: selectedTask)
                self.reloadTableViewData()
            }

            actionSheet.addAction(action)
        }
    }

// MARK: - Match TableView to certain Task

    private func matchTableView(to task: TodoTasks) throws -> UITableView {
        let tableView = self.sampleTableView.enumerated().filter { (index, _) in
            TodoTasks.getTask(index) == task
        }

        guard let tableView = tableView.first?.element else {
            throw ViewConfigureError.invalidTask
        }

        return tableView
    }
}

// MARK: - Table View DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let taskIndex = self.sampleTableView.firstIndex(of: tableView),
              let todosAtCertainTask = self.todoList[TodoTasks.getTask(taskIndex)]
        else {
            return 0
        }

        return todosAtCertainTask.count
    }

    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MainTableViewCell.self)

        guard let taskIndex = self.sampleTableView.firstIndex(of: tableView),
              let todosAtCertainTask = self.todoList[TodoTasks.getTask(taskIndex)]
        else {
            return cell
        }

        let todo = todosAtCertainTask[indexPath.row]

        cell.configureTodo(for: todo)

        return cell
    }
}

// MARK: - Table View Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive, title: MainControllerScript.delete
        ) { [weak self] _, _, completionHandler in
            guard let self = self else {
                return
            }

            self.presentDeleteAlert(indexPath: indexPath, in: tableView)
            completionHandler(true)
        }

        delete.image = UIImage(named: MainControllerImageName.deleteImage)

        return UISwipeActionsConfiguration(actions: [delete])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let taskIndex = self.sampleTableView.firstIndex(of: tableView),
              let todosAtCertainTask = self.todoList[TodoTasks.getTask(taskIndex)]
        else {
            return
        }

        self.presentNavigationController()

        let todo = todosAtCertainTask[indexPath.row]

        self.editViewController.setUpDefaultValue(todo: todo, at: TodoTasks.getTask(taskIndex))
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let taskIndex = self.sampleTableView.firstIndex(of: tableView),
              let todosAtCertainTask = self.todoList[TodoTasks.getTask(taskIndex)]
        else {
            return nil
        }

        let header = tableView.dequeueReusableHeaderFooterView(
            withClass: MainTableViewHeaderView.self
        )
        let todoCount = todosAtCertainTask.count

        header.configureContents(
            todoCount: todoCount, withTitle: TodoTasks.getTask(taskIndex).rawValue
        )

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MainControllerConstraint.headerHeight
    }
}

// MARK: - Edit View Controller Delegate Methods

extension MainViewController: EditEventAvailable {

    func editViewControllerDidCancel(_ editViewController: EditViewController) {
        editViewController.dismiss(animated: true, completion: nil)
    }

    func editViewControllerDidFinish(_ editViewController: EditViewController) {
        self.reloadTableViewData()

        editViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Magic Numbers

private extension MainViewController {

    private enum MainControllerColor {

        static let stackViewSpaceColor: UIColor = .systemGray4
        static let backgroundColor: UIColor = .systemGray6
        static let tableViewBackgroundColor: UIColor = .white
    }

    private enum MainControllerScript {

        static let title = "Project Manager"
        static let deleteConfirmMessage = "정말 삭제하시나요?"
        static let cancel = "취소"
        static let delete = "삭제"
        static let confirm = "확인"
        static let failureMessage = "요청하신 작업을 실패하였습니다"
        static let moveTo = "Move to "
    }

    private enum MainControllerConstraint {

        static let stackViewSpace: CGFloat = 10
        static let estimatedCellHeight: CGFloat = 100
        static let headerHeight: CGFloat = 33
    }

    private enum MainControllerImageName {

        static let plusButtonImage = "plus"
        static let deleteImage = "trash.circle"
    }

    private enum MainVCMagicNumber {

        static let minimumPressDuration: TimeInterval = 2
    }
}
