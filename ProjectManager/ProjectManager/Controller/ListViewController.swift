//
//  ProjectManager - ListViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class ListViewController: UIViewController {
    private enum ListSection: Hashable {
        case main
    }
    
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constraint.stackViewSpacing
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.systemGray5
        return stackView
    }()
    
    private enum Constraint {
        static let stackViewSpacing: CGFloat = 5
    }
    
    private let todoTableView = ListTableView()
    private let doingTableView = ListTableView()
    private let doneTableView = ListTableView()
    
    private typealias ListDataSource = UITableViewDiffableDataSource<ListSection, TodoModel>
    private lazy var todoDataSource = configureDataSource(of: todoTableView)
    private lazy var doingDataSource = configureDataSource(of: doingTableView)
    private lazy var doneDataSource = configureDataSource(of: doneTableView)
    
    private var todoModels: [TodoModel] {
        MockDataManager.shared.fetchList(status: .todo)
    }
    private var doingModels: [TodoModel] {
        MockDataManager.shared.fetchList(status: .doing)
    }
    private var doneModels: [TodoModel] {
        MockDataManager.shared.fetchList(status: .done)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureContentView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = ListViewTitle.navigationBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(tappedAddButton))
    }
    
    @objc private func tappedAddButton() {
        let newTodoItem = TodoModel()
        let todoViewController = TodoViewController()
        
        todoViewController.configureAddView(with: newTodoItem)
        showTodoItemViewController(todoViewController)
    }
    
    private func showTodoItemViewController(_ viewController: UIViewController) {
        let viewController = UINavigationController(rootViewController: viewController)
        
        viewController.modalPresentationStyle = .formSheet
        viewController.preferredContentSize = TodoViewValue.size
        
        present(viewController, animated: true)
    }
    
    private func configureContentView() {
        view.backgroundColor = .white
        configureTableViews()
        configureLayout()
        applyAllSnapshot()
        addTodoObserver()
    }
    
    private func configureTableViews() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        
        tableviews.forEach {
            $0.delegate = self
            listStackView.addArrangedSubview($0)
            $0.addGestureRecognizer(UILongPressGestureRecognizer(
                target: self,
                action: #selector(self.pressTableViewCell))
            )
        }
    }
    
    private func configureLayout() {
        view.addSubview(listStackView)
        
        NSLayoutConstraint.activate([
            listStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            listStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addTodoObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateView),
            name: Notification.Name.mockModels,
            object: nil)
    }
    
    @objc private func updateView() {
        applyAllSnapshot()
        updateHeaderView()
    }
    
    private func updateHeaderView() {
        [todoTableView, doingTableView, doneTableView].forEach {
            guard let headerView = $0.headerView(forSection: 0) as? ListHeaderView else { return }
            
            switch headerView.status {
            case .todo:
                headerView.updateCountLabel(todoModels.count)
            case .doing:
                headerView.updateCountLabel(doingModels.count)
            case .done:
                headerView.updateCountLabel(doneModels.count)
            default:
                return
            }
        }
    }
}

// MARK: - configure Popover
extension ListViewController {
    @objc func pressTableViewCell(_ sender: UILongPressGestureRecognizer) {
        guard let tableView = sender.view as? UITableView else { return }
        
        let location = sender.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: location),
              let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let alert = makeAlert(for: tableView, indexPath: indexPath)
        
        presentPopover(alert: alert, sourceView: cell)
    }
    
    private func makeAlert(for tableView: UITableView, indexPath: IndexPath) -> UIAlertController {
        guard let cellItem = fetchCellItem(from: tableView, indexPath: indexPath) else {
            return UIAlertController(title: TodoError.loadError.title,
                                     message: TodoError.loadError.message,
                                     preferredStyle: .alert)
        }
        
        let moveToTodo = UIAlertAction(title: AlertMenu.toTodo, style: .default) { _ in
            MockDataManager.shared.update(todo: cellItem, status: .todo)
            self.updateView()
        }
        let moveToDoing = UIAlertAction(title: AlertMenu.toDoing, style: .default) { _ in
            MockDataManager.shared.update(todo: cellItem, status: .doing)
            self.updateView()
        }
        let moveToDone = UIAlertAction(title: AlertMenu.toDone, style: .default) { _ in
            MockDataManager.shared.update(todo: cellItem, status: .done)
            self.updateView()
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        switch tableView {
        case todoTableView:
            alert.addAction(moveToDoing)
            alert.addAction(moveToDone)
        case doingTableView:
            alert.addAction(moveToTodo)
            alert.addAction(moveToDone)
        case doneTableView:
            alert.addAction(moveToTodo)
            alert.addAction(moveToDoing)
        default:
            break
        }
        
        return alert
    }
    
    private func presentPopover(alert: UIAlertController, sourceView: UITableViewCell) {
        guard let popover = alert.popoverPresentationController else { return }
        
        popover.sourceView = sourceView
        popover.sourceRect = sourceView.bounds
        
        present(alert, animated: true)
    }
}

// MARK: - TableView DataSource and Snapshot
extension ListViewController {
    private func configureDataSource(of tableView: ListTableView) -> ListDataSource {
        let dataSource = ListDataSource(tableView: tableView) { tableView, indexPath, todoItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewValue.cellIdentifier, for: indexPath) as? ListTableViewCell
            
            cell?.configureContent(with: todoItem)
            return cell
        }
        return dataSource
    }
    
    func applyAllSnapshot() {
        applySnapshot(todoTableView)
        applySnapshot(doingTableView)
        applySnapshot(doneTableView)
    }
    
    func applySnapshot(_ tableView: ListTableView) {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, TodoModel>()
        snapshot.appendSections([.main])
        
        switch tableView {
        case todoTableView:
            snapshot.appendItems(todoModels)
            todoDataSource.apply(snapshot)
        case doingTableView:
            snapshot.appendItems(doingModels)
            doingDataSource.apply(snapshot)
        case doneTableView:
            snapshot.appendItems(doneModels)
            doneDataSource.apply(snapshot)
        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ListTableViewValue.headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderViewValue.identifier) as? ListHeaderView else {
            return UIView()
        }
        
        switch tableView {
        case todoTableView:
            headerView.configureView(status: ListHeaderView.HeaderStatus.todo,
                                     count: todoModels.count)
        case doingTableView:
            headerView.configureView(status: ListHeaderView.HeaderStatus.doing,
                                     count: doingModels.count)
        case doneTableView:
            headerView.configureView(status: ListHeaderView.HeaderStatus.done,
                                     count: doneModels.count)
        default:
            break
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellItem = fetchCellItem(from: tableView, indexPath: indexPath) else { return }
        
        let editViewController = TodoViewController()
        editViewController.configureEditView(with: cellItem)
        
        showTodoItemViewController(editViewController)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func fetchCellItem(from tableView: UITableView, indexPath: IndexPath) -> TodoModel? {
        guard let dataSource = tableView.dataSource as? ListDataSource,
              let cellItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        return cellItem
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = makeDeleteAction(tableView, indexPath: indexPath)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func makeDeleteAction(_ tableView: UITableView, indexPath: IndexPath) -> UIContextualAction{
        let delete = UIContextualAction(style: .destructive, title: SwipeActionTitle.delete) { _, _, _ in
            guard let cellItem = self.fetchCellItem(from: tableView, indexPath: indexPath) else { return }
            
            MockDataManager.shared.remove(todo: cellItem)
            self.updateView()
        }
        
        delete.image = UIImage(systemName: SwipeActionTitle.deleteImage)
        return delete
    }
}
