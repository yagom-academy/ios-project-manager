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
    
    private let tableStackView: UIStackView = {
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
    
    private lazy var todoDataSource: UITableViewDiffableDataSource<ListSection, TodoModel> = configureDataSource(of: todoTableView)
    private lazy var doingDataSource: UITableViewDiffableDataSource<ListSection, TodoModel> = configureDataSource(of: doingTableView)
    private lazy var doneDataSource: UITableViewDiffableDataSource<ListSection, TodoModel> = configureDataSource(of: doneTableView)
    
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
        applyAllSnapshot()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
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
    }
    
    private func setTableViews() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        
        tableviews.forEach {
            $0.delegate = self
            tableStackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        view.addSubview(tableStackView)
        
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView DataSource and Snapshot
extension ListViewController {
    private func configureDataSource(of tableView: ListTableView) -> UITableViewDiffableDataSource<ListSection, TodoModel> {
        let dataSource = UITableViewDiffableDataSource<ListSection, TodoModel>(tableView: tableView) { tableView, indexPath, todoItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell
            
            cell?.configureContent(title: todoItem.title,
                                   body: todoItem.body,
                                   date: todoItem.date.convertDoubleToDate())
            return cell
        }
        return dataSource
    }
    
    private func applyAllSnapshot() {
        applySnapshot(todoTableView)
        applySnapshot(doingTableView)
        applySnapshot(doneTableView)
    }
    
    private func applySnapshot(_ tableView: ListTableView) {
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
            requestViewUpdate(to: headerView, title: "TODO", itemCount: todoModels.count)
        case doingTableView:
            requestViewUpdate(to: headerView, title: "DOING", itemCount: doingModels.count)
        case doneTableView:
            requestViewUpdate(to: headerView, title: "DONE", itemCount: doneModels.count)
        default:
            break
        }
        return headerView
    }
    
    private func requestViewUpdate(to headerView: ListHeaderView, title: String, itemCount: Int) {
        headerView.setTitle(title)
        headerView.updateCount(itemCount)
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
        guard let dataSource = tableView.dataSource as? UITableViewDiffableDataSource<ListSection, TodoModel>,
              let todoItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        return todoItem
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = fetchDeleteAction(tableView, indexPath: indexPath)
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    private func fetchDeleteAction(_ tableView: UITableView, indexPath: IndexPath) -> UIContextualAction{
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            guard let cellItem = self.fetchCellItem(from: tableView, indexPath: indexPath) else { return }
            
            MockDataManager.shared.removeTodo(item: cellItem)
            self.applyAllSnapshot()
            tableView.reloadData()
            completion(true)
        }
        
        delete.image = UIImage(systemName: "xmark.bin")
        return delete
    }
}

// MARK: - AddTodoViewDelegate
extension ListViewController: AddTodoViewDelegate {
    func addNewTodoItem(with item: TodoModel) {
        MockDataManager.shared.createNewTodo(item: item)
        applySnapshot(todoTableView)
        todoTableView.reloadData()
    }
}

// MARK: - EditTodoViewDelegate
extension ListViewController: EditTodoViewDelegate {
    func editTodoItem(with item: TodoModel) {
        MockDataManager.shared.updateTodo(item: item)
        applyAllSnapshot()
    }
}
