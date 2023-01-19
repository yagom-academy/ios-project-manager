//
//  ProjectManager - MainViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, ListItem>
    
    enum Section {
        case main
    }
    
    // MARK: Properties
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        return stackView
    }()
    private let todoListStackView = ListStackView(title: Constant.todo)
    private let doingListStackView = ListStackView(title: Constant.doing)
    private let doneListStackView = ListStackView(title: Constant.done)
    
    private lazy var todoListDataSource = configureDataSource(of: .todo)
    private lazy var doingListDataSource = configureDataSource(of: .doing)
    private lazy var doneListDataSource = configureDataSource(of: .done)
    
    private var mainViewModel: MainViewModel = .init()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundColors()
        configureNavigationBar()
        configureLayout()
        configureTableViewDelegate()
        bindHandlers()
        updateAllCountLabels()
    }
    
    // MARK: Private Methods
    
    private func configureBackgroundColors() {
        view.backgroundColor = Constant.viewBackgroundColor
        [todoListStackView, doingListStackView, doneListStackView].forEach {
            $0.configureBackgroundColor()
        }
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.title = Constant.navigationTitle
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addListItem)
        )
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        [todoListStackView, doingListStackView, doneListStackView].forEach {
            totalStackView.addArrangedSubview($0)
        }
        view.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            totalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureTableViewDelegate() {
        [todoListStackView, doneListStackView, doingListStackView].forEach {
            $0.listTableView.delegate = self
        }
    }
    
    private func bindHandlers() {
        mainViewModel.bindTodo { [weak self] todoListItems in
            self?.configureSnapShot(of: .todo, listItems: todoListItems)
            self?.todoListStackView.updateCountLabel(todoListItems.count)
        }
        
        mainViewModel.bindDoing { [weak self] doingListItems in
            self?.configureSnapShot(of: .doing, listItems: doingListItems)
            self?.doingListStackView.updateCountLabel(doingListItems.count)
        }
        
        mainViewModel.bindDone { [weak self] doneListItems in
            self?.configureSnapShot(of: .done, listItems: doneListItems)
            self?.doneListStackView.updateCountLabel(doneListItems.count)
        }
    }
    
    private func updateAllCountLabels() {
        [todoListStackView, doingListStackView, doneListStackView].forEach {
            $0.updateCountLabel(.zero)
        }
    }
    
    @objc func addListItem() {
        let viewController = ListFormViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.delegate = self
        navigationController.modalPresentationStyle = .formSheet
        navigationController.preferredContentSize = .init(
            width: view.frame.width * 0.5,
            height: view.frame.height * 0.7
        )
        present(navigationController, animated: true)
    }
}

// MARK: - UITableViewDiffableDataSource & SnapShot

extension MainViewController {
    private func configureDataSource(of type: ListType) -> DataSource {
        let tableView: UITableView
        
        switch type {
        case .todo:
            tableView = todoListStackView.listTableView
        case .doing:
            tableView = doingListStackView.listTableView
        case .done:
            tableView = doneListStackView.listTableView
        }
        
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ListItemCell.identifier,
                for: indexPath
            ) as? ListItemCell else {
                return UITableViewCell()
            }
            
            let listItemCellViewModel = ListItemCellViewModel(listItem: item, listType: type)
            
            cell.bind(listItemCellViewModel)
            cell.update(item)
            cell.delegate = self
            
            return cell
        }
        
        return dataSource
    }
    
    private func configureSnapShot(of type: ListType, listItems: [ListItem]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, ListItem>()
        
        snapShot.appendSections([.main])
        snapShot.appendItems(listItems)
        
        switch type {
        case .todo:
            todoListDataSource.apply(snapShot, animatingDifferences: true)
        case .doing:
            doingListDataSource.apply(snapShot, animatingDifferences: true)
        case .done:
            doneListDataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ListItemCell,
              let cellViewModel = cell.viewModel else { return }
        
        let formViewModel = ListFormViewModel(
            index: indexPath.row,
            listItem: cellViewModel.currentItem,
            listType: cellViewModel.listType
        )
        let viewController = ListFormViewController(formViewModel: formViewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.delegate = self
        navigationController.modalPresentationStyle = .formSheet
        navigationController.preferredContentSize = .init(
            width: view.frame.width * 0.5,
            height: view.frame.height * 0.7
        )
        present(navigationController, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive,
            title: Constant.swipeDelete
        ) { _, _, _ in
            guard let cell = tableView.cellForRow(at: indexPath) as? ListItemCell,
                  let cellViewModel = cell.viewModel
            else {
                return
            }
            
            self.mainViewModel.delete(at: indexPath.row, type: cellViewModel.listType)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - ListFormViewControllerDelegate

extension MainViewController: ListFormViewControllerDelegate {
    func addNewItem(_ listItem: ListItem) {
        mainViewModel.appendTodoList(item: listItem)
    }
    
    func ediItem(of type: ListType, at index: Int, title: String, body: String, dueDate: Date) {
        mainViewModel.editItem(of: type, at: index, title: title, body: body, dueDate: dueDate)
    }
}

// MARK: - MenuPresentable

extension MainViewController: MenuPresentable {
    func move(listItem: ListItem, from currentType: ListType, to newType: ListType) {
        mainViewModel.move(targetItem: listItem, from: currentType, to: newType)
    }
}

// MARK: - NameSpace

private enum Constant {
    static let navigationTitle = "Project Manager"
    static let todo = "TODO"
    static let doing = "DOING"
    static let done = "DONE"
    
    static let moveToToDo = "Move to TODO"
    static let moveToDoing = "Move to DOING"
    static let moveToDone = "Move to DONE"
    
    static let swipeDelete = "Delete"
    
    static let viewBackgroundColor: UIColor = .init(cgColor: CGColor(
        red: 246,
        green: 246,
        blue: 246,
        alpha: 1)
    )
}
