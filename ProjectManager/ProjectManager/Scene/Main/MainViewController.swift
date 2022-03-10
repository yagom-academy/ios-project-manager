//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

// MARK: - Properties

    private var todoList = [Todo]() {
        didSet {
            self.reloadTableView()
        }
    }

    private let dataProvider = DataProvider()
    private let businessLogic = BusinessLogic()

// MARK: - View Components

    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: MainVCImageName.plusButtonImage)
        button.target = self
        button.action = #selector(plusButtonDidTap)

        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = MainVCConstraint.stackViewSpace
        stackView.distribution = .fillEqually
        stackView.backgroundColor = MainVCColor.stackViewSpaceColor
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

// MARK: - Modal View Controller

    private let editViewController: EditViewController = {
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

// MARK: - Observing Method(s)

    private func observeDateProvider() {
        dataProvider.updated = { [weak self] in
            guard let self = self else {
                return
            }

            self.todoList = self.dataProvider.updatedList()
        }
        self.dataProvider.reload()
    }

// MARK: - Reload View

    private func reloadTableView() {
        self.todoTableView.reloadData()
        self.doingTableView.reloadData()
        self.doneTableView.reloadData()
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
        self.stackView.addArrangedSubview(self.todoTableView)
        self.stackView.addArrangedSubview(self.doingTableView)
        self.stackView.addArrangedSubview(self.doneTableView)
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
        self.title = MainVCScript.title
        self.navigationItem.rightBarButtonItem = self.plusButton
        self.navigationController?.navigationBar.barTintColor = MainVCColor.backgroundColor
    }

// MARK: - SetUp Table View

    private func setUpTableView() {
        self.setUpTableViewDataSource()
        self.setUpTableViewDelegate()
        self.registerTableView()
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

    private func registerTableView() {
        self.registerTableViewCell()
        self.registerTableViewHeader()
    }

    private func registerTableViewCell() {
        self.todoTableView.register(cellWithClass: MainTableViewCell.self)
        self.doingTableView.register(cellWithClass: MainTableViewCell.self)
        self.doneTableView.register(cellWithClass: MainTableViewCell.self)
    }

    private func registerTableViewHeader() {
        self.todoTableView.register(headerFooterViewClassWith: MainTableViewHeaderView.self)
        self.doingTableView.register(headerFooterViewClassWith: MainTableViewHeaderView.self)
        self.doneTableView.register(headerFooterViewClassWith: MainTableViewHeaderView.self)
    }

// MARK: - SetUp TableView LongPressGesture

    private func setUpTableViewGesture() {
        self.addLongPressGestureRecognizer(
            tableView: self.todoTableView, selector: #selector(todoTableViewLongPressed(sender:))
        )
        self.addLongPressGestureRecognizer(
            tableView: self.doingTableView, selector: #selector(doingTableViewLongPressed(sender:))
        )
        self.addLongPressGestureRecognizer(
            tableView: self.doneTableView, selector: #selector(doneTableViewLongPressed(sender:))
        )
    }

    private func addLongPressGestureRecognizer(tableView: UITableView, selector: Selector) {
        let longPress = UILongPressGestureRecognizer(target: self, action: selector)
        longPress.minimumPressDuration = MainVCMagicNumber.minimumPressDuration
        tableView.addGestureRecognizer(longPress)
    }

// MARK: - Button Tap Actions

    @objc
    private func plusButtonDidTap() {
        self.presentNavigationController()
        self.editViewController.resetToDefaultValue()
    }

    @objc
    private func todoTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.todoTableView)
            self.presentSectionChangeActionSheet(at: touchPoint, in: self.todoTableView)
        }
    }

    @objc
    private func doingTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.doingTableView)
            self.presentSectionChangeActionSheet(at: touchPoint, in: self.doingTableView)
        }
    }

    @objc
    private func doneTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.doneTableView)
            self.presentSectionChangeActionSheet(at: touchPoint, in: self.doneTableView)
        }
    }

    private func presentSectionChangeActionSheet(at touchPoint: CGPoint, in tableView: UITableView) {
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else {
            return
        }

        let selectedTodo = self.divideData(as: tableView)[indexPath.row]
        let otherSections = TodoSection.allCases.filter { section in
            section != selectedTodo.section
        }
        let actionSheet = self.setUpActionSheet(in: indexPath, of: tableView)

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

    private func setUpAlertActionWithOtherSections(sections: [TodoSection], selectedTodo: Todo, at actionSheet: UIAlertController) {
        sections.forEach { section in
            let action = UIAlertAction(
                title: MainVCScript.moveTo + section.rawValue, style: .default
            ) { [weak self] _ in
                guard let self = self else {
                    return
                }

                self.dataProvider.edit(todo: selectedTodo, in: section)
            }

            actionSheet.addAction(action)
        }
    }

// MARK: - Present Method(s)

    private func presentDeleteAlert(indexPath: IndexPath, inSection tableView: UITableView) {
        let alert = UIAlertController(
            title: MainVCScript.deleteConfirmMessage, message: nil, preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: MainVCScript.cancel, style: .cancel) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.dismiss(animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: MainVCScript.delete, style: .destructive) { [weak self] _ in
            guard let self = self else {
                return
            }

            let deleteTodo = self.divideData(as: tableView)[indexPath.row]
            self.dataProvider.delete(todo: deleteTodo)
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func presentFailureAlert() {
        let alert = UIAlertController(
            title: MainVCScript.failureMessage, message: nil, preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: MainVCScript.confirm, style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }

            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func presentNavigationController() {
        self.editViewController.dataProvider = self.dataProvider
        let navigationController = UINavigationController(
            rootViewController: self.editViewController
        )

        self.present(navigationController, animated: true, completion: nil)

    }

    // MARK: - Form Data Methods

    private func divideData(as tableView: UITableView) -> [Todo] {
        guard let section = self.matchSection(tableView: tableView) else {
            return [Todo]()
        }

        return businessLogic.filterTodos(by: section, in: self.todoList)
    }

    private func matchSection(tableView: UITableView) -> TodoSection? {
        switch tableView {
        case self.todoTableView:
            return TodoSection.todo
        case self.doingTableView:
            return TodoSection.doing
        case self.doneTableView:
            return TodoSection.done
        default:
            return nil
        }
    }
}

// MARK: - Table View DataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.divideData(as: tableView).count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MainTableViewCell.self)
        let todo = self.divideData(as: tableView)[indexPath.row]

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
            style: .destructive, title: MainVCScript.delete
        ) { [weak self] _, _, completionHandler in
            guard let self = self else {
                return
            }

            self.presentDeleteAlert(indexPath: indexPath, inSection: tableView)
            completionHandler(true)
        }

        delete.image = UIImage(named: MainVCImageName.deleteImage)

        return UISwipeActionsConfiguration(actions: [delete])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentNavigationController()
        let todo = self.divideData(as: tableView)[indexPath.row]
        self.editViewController.setUpDefaultValue(todo: todo)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withClass: MainTableViewHeaderView.self)
        let todoCountInSection = self.divideData(as: tableView).count
        if let setUpSection = self.matchSection(tableView: tableView) {
            header.configureContents(todoCount: todoCountInSection, in: setUpSection.rawValue)
        }

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MainVCConstraint.headerHeight
    }
}

// MARK: - Edit View Controller Delegate Methods

extension MainViewController: EditViewControllerDelegate {

    func editViewControllerDidCancel(_ editViewController: EditViewController) {
        editViewController.dismiss(animated: true, completion: nil)
    }

    func editViewControllerDidFinish(_ editViewController: EditViewController) {
        self.todoList = self.dataProvider.updatedList()
        editViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Magic Numbers

private enum MainVCColor {

    static let viewBackgroundColor: UIColor = .white
    static let stackViewSpaceColor: UIColor = .systemGray4
    static let backgroundColor: UIColor = .systemGray6
}

private enum MainVCScript {
    static let title = "Project Manager"
    static let deleteConfirmMessage = "정말 삭제하시나요?"
    static let cancel = "취소"
    static let delete = "삭제"
    static let confirm = "확인"
    static let failureMessage = "요청하신 작업을 실패하였습니다"
    static let moveTo = "Move to "
}

private enum MainVCConstraint {
    static let navigationBarStartPoint: CGFloat = 0
    static let navigationBarHeight: CGFloat = 60
    static let stackViewSpace: CGFloat = 10
    static let stackViewTopAnchor: CGFloat = 26
    static let estimatedCellHeight: CGFloat = 100
    static let headerHeight: CGFloat = 33
}

private enum MainVCImageName {
    static let plusButtonImage = "plus"
    static let deleteImage = "trash.circle"
}

private enum MainVCMagicNumber {
    static let minimumPressDuration: TimeInterval = 2
}
