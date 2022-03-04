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

// MARK: - View Components

    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: MainVCImageName.plusButtonImage)
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
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }()

    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }()

    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = MainVCColor.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = MainVCConstraint.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension

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
        self.stackView.addArrangedSubview(self.todoTableView)
        self.stackView.addArrangedSubview(self.doingTableView)
        self.stackView.addArrangedSubview(self.doneTableView)
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

// MARK: - SetUp TableView LongPressGesture

    private func setUpTableViewGesture() {
        self.todoTableViewAddGestureRecognizer()
        self.doingTableViewAddGestureRecognizer()
        self.doneTableViewAddGestureRecognizer()
    }

    private func todoTableViewAddGestureRecognizer() {
        let todoLongPress = UILongPressGestureRecognizer(
            target: self, action: #selector(todoTableViewLongPressed(sender:))
        )
        todoLongPress.minimumPressDuration = MainVCMagicNumber.minimumPressDuration
        self.todoTableView.addGestureRecognizer(todoLongPress)
    }

    private func doingTableViewAddGestureRecognizer() {
        let doingLongPress = UILongPressGestureRecognizer(
            target: self, action: #selector(doingTableViewLongPressed(sender:))
        )
        doingLongPress.minimumPressDuration = MainVCMagicNumber.minimumPressDuration
        self.doingTableView.addGestureRecognizer(doingLongPress)
    }

    private func doneTableViewAddGestureRecognizer() {
        let doneLongPress = UILongPressGestureRecognizer(
            target: self, action: #selector(doneTableViewLongPressed(sender:))
        )
        doneLongPress.minimumPressDuration = MainVCMagicNumber.minimumPressDuration
        self.doneTableView.addGestureRecognizer(doneLongPress)
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

// MARK: - Button Tap Actions

    @objc
    private func plusButtonDidTap() {
        self.editViewController.dataProvider = self.dataProvider
        let navigationController = UINavigationController(
            rootViewController: self.editViewController
        )

        self.present(navigationController, animated: true, completion: nil)
    }

    @objc
    private func todoTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.todoTableView)
            self.presentLongPressActionSheet(at: touchPoint, in: self.todoTableView)
        }
    }

    @objc
    private func doingTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.doingTableView)
            self.presentLongPressActionSheet(at: touchPoint, in: self.doingTableView)
        }
    }

    @objc
    private func doneTableViewLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: self.doneTableView)
            self.presentLongPressActionSheet(at: touchPoint, in: self.doneTableView)
        }
    }

    private func presentLongPressActionSheet(at touchPoint: CGPoint, in tableView: UITableView) {
        if let indexPath = tableView.indexPathForRow(at: touchPoint) {
            let pressedTodo = self.divideData(as: tableView)[indexPath.row]
            let otherSections = TodoSection.allCases.filter { section in
                section != pressedTodo.section
            }
            let actionSheet = self.setUpActionSheet(in: indexPath, of: tableView)

            otherSections.forEach { section in
                let action = UIAlertAction(
                    title: MainVCScript.moveTo + section.rawValue, style: .default
                ) { _ in
                    self.dataProvider.edit(todo: pressedTodo, in: section)
                }

                actionSheet.addAction(action)
            }

            self.present(actionSheet, animated: true, completion: nil)
        }
    }

// MARK: - Present Alert Method(s)

    private func presentDeleteAlert(indexPath: IndexPath, inSection tableView: UITableView) {
        let alert = UIAlertController(
            title: MainVCScript.deleteConfirmMessage, message: nil, preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: MainVCScript.cancel, style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: MainVCScript.delete, style: .destructive) { _ in
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
        let okAction = UIAlertAction(title: MainVCScript.confirm, style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Form Data Methods

        private func divideData(as tableView: UITableView) -> [Todo] {
            switch tableView {
            case self.todoTableView:
                return self.filterSection(.todo)
            case self.doingTableView:
                return self.filterSection(.doing)
            case self.doneTableView:
                return self.filterSection(.done)
            default:
                return [Todo]()
            }
        }

        private func filterSection(_ section: TodoSection) -> [Todo] {
            let todos = self.todoList.filter { todo in
                todo.section == section
            }

            return todos
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
        ) { _, _, completionHandler in
            self.presentDeleteAlert(indexPath: indexPath, inSection: tableView)
            completionHandler(true)
        }

        delete.image = UIImage(named: MainVCImageName.deleteImage)

        return UISwipeActionsConfiguration(actions: [delete])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Edit ViewController Delegate Methods

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
}

private enum MainVCImageName {
    static let plusButtonImage = "plus"
    static let deleteImage = "trash.circle"
}

private enum MainVCMagicNumber {
    static let minimumPressDuration: TimeInterval = 2
}
