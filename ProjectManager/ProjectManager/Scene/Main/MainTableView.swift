//
//  MainTableView.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/10.
//

import UIKit

class MainTableView: NSObject, UITableViewDataSource, UITableViewDelegate, SectionDivided {

// MARK: - Properties

    var todoList = [Todo]() {
       didSet {
           self.tableView.reloadData()
       }
   }
    var section: TodoSection
    var dataProvider: DataProvider?
    private weak var controllerDelegate: ScenePresentable?

// MARK: - View Components

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = MainTableViewColor.tableViewBackgroundColor
        tableView.estimatedRowHeight = MainTableViewConstraints.estimatedCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

// MARK: - Initializer

    required init(section: TodoSection, dataProvider: DataProvider) {
        self.section = section
        self.dataProvider = dataProvider

        super.init()

        self.tableView.register(cellWithClass: MainTableViewCell.self)

        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.commonInit()
    }

// MARK: - Internal Methods

    func setDelegate(delegate: ScenePresentable) {
        self.controllerDelegate = delegate
    }

    func reloadTodoList() {
        guard let dataProvider = self.dataProvider else {
            return
        }

        self.todoList = dataProvider.updatedList()
    }

// MARK: - Private Methods

    private func commonInit() {
        self.updateList()
    }

    private func updateList() {
        guard let dataProvider = self.dataProvider else {
            return
        }

        dataProvider.updated = { [weak self] in
            guard let self = self else {
                return
            }

            self.todoList = dataProvider.updatedList()
        }

        dataProvider.reload()
    }

// MARK: - Table View DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataFormatter.filterTodos(by: self.section, in: self.todoList).count
    }

    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MainTableViewCell.self)
        let todos = DataFormatter.filterTodos(by: self.section, in: self.todoList)
        let todo = todos[indexPath.row]

        cell.configureTodo(for: todo)

        return cell
    }

// MARK: - Table View Delegate

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive, title: MainTableViewScript.delete
        ) { [weak self] _, _, completionHandler in
            guard let self = self else {
                return
            }

            self.controllerDelegate?.presentDeleteAlert(indexPath: indexPath, in: self)
            completionHandler(true)
        }

        delete.image = UIImage(named: MainTableViewImage.deleteImage)

        return UISwipeActionsConfiguration(actions: [delete])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.controllerDelegate?.presentNavigationController()
        let todos = DataFormatter.filterTodos(by: self.section, in: self.todoList)
        let todo = todos[indexPath.row]
        self.controllerDelegate?.editViewController.setUpDefaultValue(todo: todo)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withClass: MainTableViewHeaderView.self
        )
        let todoInSection = DataFormatter.filterTodos(by: self.section, in: self.todoList)
        let todoCountInSection = todoInSection.count

        header.configureContents(todoCount: todoCountInSection, in: self.section.rawValue)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MainTableViewConstraints.headerHeight
    }
}

private enum MainTableViewColor {

    static let tableViewBackgroundColor: UIColor = .white
}

private enum MainTableViewScript {

    static let delete = "삭제"
}

private enum MainTableViewConstraints {

    static let estimatedCellHeight: CGFloat = 100
    static let headerHeight: CGFloat = 33
}

private enum MainTableViewImage {

    static let deleteImage = "trash.circle"
}
