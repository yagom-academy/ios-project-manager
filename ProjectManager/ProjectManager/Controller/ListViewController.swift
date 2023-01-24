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
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.systemGray5
        return stackView
    }()
    
    private let todoTableView = ListTableView()
    private let doingTableView = ListTableView()
    private let doneTableView = ListTableView()
    
    private typealias ListDataSource = UITableViewDiffableDataSource<ListSection, TodoModel>
    private lazy var todoDataSource: ListDataSource = configureDataSource(of: todoTableView)
    private lazy var doingDataSource: ListDataSource = configureDataSource(of: doingTableView)
    private lazy var doneDataSource: ListDataSource = configureDataSource(of: doneTableView)
    
    private var todoModels: [TodoModel] {
        MockDataManager.shared.mockModels.filter { $0.status == .todo }
    }
    private var doingModels: [TodoModel] {
        MockDataManager.shared.mockModels.filter { $0.status == .doing }
    }
    private var doneModels: [TodoModel] {
        MockDataManager.shared.mockModels.filter { $0.status == .done }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        let addViewController = AddTodoViewController()
        
        addViewController.delegate = self
        
        showTodoItemView(with: newTodoItem, nextViewController: addViewController)
    }
    
    private func showTodoItemView(with todoItem: TodoModel, nextViewController: UIViewController) {
        let viewController = UINavigationController(rootViewController: nextViewController)
        
        viewController.modalPresentationStyle = .formSheet
        viewController.preferredContentSize = CGSize(width: 650, height: 650)
        
        present(viewController, animated: true)
    }
    
    private func configureContentView() {
        setTableViews()
        configureLayout()
        applyAllSnapshot()
    }
    
    private func setTableViews() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        
        tableviews.forEach {
            $0.delegate = self
            listStackView.addArrangedSubview($0)
            $0.addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                                 action: #selector(self.pressTableView)))
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
}

// MARK: - configure Popover
extension ListViewController {
    @objc func pressTableView(_ sender: UILongPressGestureRecognizer) {
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
        
        let moveToTodo = UIAlertAction(title: AlertMenu.toTodo, style: .default) { [weak self] _ in
            MockDataManager.shared.update(todo: cellItem, status: .todo)
            self?.todoTableView.reloadData()
            tableView.reloadData()
            self?.applyAllSnapshot()
        }
        let moveToDoing = UIAlertAction(title: AlertMenu.toDoing, style: .default) { [weak self] _ in
            MockDataManager.shared.update(todo: cellItem, status: .doing)
            self?.doingTableView.reloadData()
            tableView.reloadData()
            self?.applyAllSnapshot()
        }
        let moveToDone = UIAlertAction(title: AlertMenu.toDone, style: .default) { [weak self] _ in
            MockDataManager.shared.update(todo: cellItem, status: .done)
            self?.doneTableView.reloadData()
            tableView.reloadData()
            self?.applyAllSnapshot()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
            
            cell?.configureContent(title: todoItem.title,
                                   body: todoItem.body,
                                   date: todoItem.date.convertDoubleToDate())
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
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListHeaderView.identifier) as? ListHeaderView else {
            return UIView()
        }
        
        switch tableView {
        case todoTableView:
            headerView.updateView(title: ListViewTitle.Header.todo, count: todoModels.count)
        case doingTableView:
            headerView.updateView(title: ListViewTitle.Header.doing, count: doingModels.count)
        case doneTableView:
            headerView.updateView(title: ListViewTitle.Header.done, count: doneModels.count)
        default:
            break
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellItem = fetchCellItem(from: tableView, indexPath: indexPath) else { return }
        
        let editViewController = EditTodoViewController()
        editViewController.delegate = self
        editViewController.prepareView(with: cellItem)
        
        showTodoItemView(with: cellItem, nextViewController: editViewController)
        
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
            tableView.reloadData()
            self.applyAllSnapshot()
        }
        
        delete.image = UIImage(systemName: SwipeActionTitle.deleteImage)
        return delete
    }
}

// MARK: - AddTodoViewDelegate
extension ListViewController: AddTodoViewDelegate {
    func add(todo item: TodoModel) {
        MockDataManager.shared.create(todo: item)
        todoTableView.reloadData()
        applySnapshot(todoTableView)
    }
}

// MARK: - EditTodoViewDelegate
extension ListViewController: EditTodoViewDelegate {
    func edit(todo item: TodoModel) {
        MockDataManager.shared.update(todo: item, status: item.status)
        applyAllSnapshot()
    }
}
