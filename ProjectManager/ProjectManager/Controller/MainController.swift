//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainController: UIViewController, ScenePresentable {

// MARK: - Properties

    let dataProvider = DataProvider()

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

    private lazy var todoTableView = MainTableView(
        section: .todo, dataProvider: self.dataProvider
    )
    private lazy var doingTableView = MainTableView(
        section: .doing, dataProvider: self.dataProvider
    )
    private lazy var doneTableView = MainTableView(
        section: .done, dataProvider: self.dataProvider
    )

// MARK: - Modal View Controller

    var editViewController: EditController = {
        let controller = EditController()
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
        self.configureStackView()
        self.configureNavigationBar()
        self.setUpTableView()
        self.setUpDelegate()
        self.setUpTableViewGesture()
    }

// MARK: - Reload View

    func reloadTableViewData() {
        self.todoTableView.reloadTodoList()
        self.doingTableView.reloadTodoList()
        self.doneTableView.reloadTodoList()
    }

// MARK: - Present Method(s)

    func presentDeleteAlert(indexPath: IndexPath, in tableView: MainTableView) {
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
            guard let self = self else {
                return
            }

            let deleteTodoInTodos = DataFormatter.filterTodos(
                by: tableView.section, in: tableView.todoList
            )
            let deleteTodo = deleteTodoInTodos[indexPath.row]
            self.dataProvider.delete(todo: deleteTodo)
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        self.present(alert, animated: true, completion: nil)
    }

    func presentNavigationController() {
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
        self.todoTableView.setDelegate(delegate: self)
        self.doingTableView.setDelegate(delegate: self)
        self.doneTableView.setDelegate(delegate: self)
        self.editViewController.mainViewDelegate = self
    }

// MARK: - Configure Views

    private func configureStackView() {
        self.view.addSubview(self.stackView)
        self.addTableViewsToStackView()
        self.setStackViewConstraints()
    }

    private func addTableViewsToStackView() {
        self.stackView.addArrangedSubview(self.todoTableView.tableView)
        self.stackView.addArrangedSubview(self.doingTableView.tableView)
        self.stackView.addArrangedSubview(self.doneTableView.tableView)
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
    }

    private func registerTableViewHeader() {
        self.todoTableView.tableView.register(
            headerFooterViewClassWith: MainTableViewHeaderView.self
        )
        self.doingTableView.tableView.register(
            headerFooterViewClassWith: MainTableViewHeaderView.self
        )
        self.doneTableView.tableView.register(
            headerFooterViewClassWith: MainTableViewHeaderView.self
        )
    }

// MARK: - SetUp TableView LongPressGesture

    private func setUpTableViewGesture() {
        self.addLongPressGestureRecognizer(
            tableView: self.todoTableView.tableView,
            selector: #selector(todoTableViewLongPressed(sender:))
        )
        self.addLongPressGestureRecognizer(
            tableView: self.doingTableView.tableView,
            selector: #selector(doingTableViewLongPressed(sender:))
        )
        self.addLongPressGestureRecognizer(
            tableView: self.doneTableView.tableView,
            selector: #selector(doneTableViewLongPressed(sender:))
        )
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
        if sender.state == .began {
            let touchPoint = sender.location(in: self.todoTableView.tableView)
            self.presentSectionChangeActionSheet(at: touchPoint, in: self.todoTableView)
        }
    }

    @objc
    private func doingTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.doingTableView.tableView)
            self.presentSectionChangeActionSheet(at: touchPoint, in: self.doingTableView)
        }
    }

    @objc
    private func doneTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.doneTableView.tableView)
            self.presentSectionChangeActionSheet(at: touchPoint, in: self.doneTableView)
        }
    }

    private func presentSectionChangeActionSheet(
        at touchPoint: CGPoint, in tableView: SectionDivided
    ) {
        guard let indexPath = tableView.tableView.indexPathForRow(at: touchPoint) else {
            return
        }

        let selectedTodos = DataFormatter.filterTodos(
            by: tableView.section, in: tableView.todoList
        )
        let selectedTodo = selectedTodos[indexPath.row]
        let otherSections = TodoSection.allCases.filter { section in
            section != selectedTodo.section
        }
        let actionSheet = self.setUpActionSheet(in: indexPath, of: tableView.tableView)

        self.setUpAlertActionWithOtherSections(
            sections: otherSections, selectedTodo: selectedTodo, at: actionSheet
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

    private func setUpAlertActionWithOtherSections(
        sections: [TodoSection], selectedTodo: Todo, at actionSheet: UIAlertController
    ) {
        sections.forEach { section in
            let action = UIAlertAction(
                title: MainControllerScript.moveTo + section.rawValue, style: .default
            ) { [weak self] _ in
                guard let self = self else {
                    return
                }

                self.dataProvider.edit(todo: selectedTodo, in: section)
                self.reloadTableViewData()
            }

            actionSheet.addAction(action)
        }
    }
}

// MARK: - Edit View Controller Delegate Methods

extension MainController: EditEventAvailable {

    func editViewControllerDidCancel(_ editViewController: EditController) {
        editViewController.dismiss(animated: true, completion: nil)
    }

    func editViewControllerDidFinish(_ editViewController: EditController) {
        self.todoTableView.reloadTodoList()
        self.doingTableView.reloadTodoList()
        self.doneTableView.reloadTodoList()

        editViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Magic Numbers

private enum MainControllerColor {

    static let stackViewSpaceColor: UIColor = .systemGray4
    static let backgroundColor: UIColor = .systemGray6
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
}

private enum MainControllerImageName {

    static let plusButtonImage = "plus"
}

private enum MainVCMagicNumber {

    static let minimumPressDuration: TimeInterval = 2
}
