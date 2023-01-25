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
    private let todoListStackView = ListStackView(title: Constant.uppercasedTodo)
    private let doingListStackView = ListStackView(title: Constant.uppercasedDoing)
    private let doneListStackView = ListStackView(title: Constant.uppercasedDone)
    
    private var todoListDataSource: DataSource?
    private var doingListDataSource: DataSource?
    private var doneListDataSource: DataSource?
    
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
        configureAllDataSource()
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
    private func configureAllDataSource() {
        todoListDataSource = configureDataSource(of: .todo)
        doingListDataSource = configureDataSource(of: .doing)
        doneListDataSource = configureDataSource(of: .done)
    }
    
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
            todoListDataSource?.apply(snapShot, animatingDifferences: true)
        case .doing:
            doingListDataSource?.apply(snapShot, animatingDifferences: true)
        case .done:
            doneListDataSource?.apply(snapShot, animatingDifferences: true)
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
            listItem: cellViewModel.listItem,
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
    func didLongPressGesture(_ sender: UIGestureRecognizer, _ viewModel: ListItemCellViewModel) {
        guard sender.state == .began else { return }
        
        showPopoverMenu(sender, viewModel)
    }
    
    func showPopoverMenu(_ sender: UIGestureRecognizer, _ viewModel: ListItemCellViewModel) {
        let actionTypes = ListType.allCases.filter { $0 != viewModel.listType }
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
        menuAlert.modalPresentationStyle = .popover
        menuAlert.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        menuAlert.popoverPresentationController?.sourceView = sender.view
        
        actionTypes.forEach {
            let action = makeAlertAction(of: $0, viewModel)
            
            menuAlert.addAction(action)
        }
        
        present(menuAlert, animated: true)
    }
    
    func makeAlertAction(of type: ListType, _ viewModel: ListItemCellViewModel) -> UIAlertAction {
        let title: String
        
        switch type {
        case .todo:
            title = Constant.moveToToDo
        case .doing:
            title = Constant.moveToDoing
        case .done:
            title = Constant.moveToDone
        }
        
        let action = UIAlertAction(title: title, style: .default) { _ in
            self.move(listItem: viewModel.listItem, from: viewModel.listType, to: type)
            viewModel.moveType(to: type)
        }
        
        return action
    }
    
    func move(listItem: ListItem, from currentType: ListType, to newType: ListType) {
        mainViewModel.move(targetItem: listItem, from: currentType, to: newType)
    }
}

// MARK: - NameSpace

private enum Constant {
    static let navigationTitle = "Project Manager"
    static let uppercasedTodo = "TODO"
    static let uppercasedDoing = "DOING"
    static let uppercasedDone = "DONE"
    
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
