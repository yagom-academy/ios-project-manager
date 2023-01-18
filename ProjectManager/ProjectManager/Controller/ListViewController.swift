//
//  ProjectManager - ListViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class ListViewController: UIViewController {
    private enum ListSection: Hashable {
        case todo
        case doing
        case done
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
    
    // 테스트용 todoModels
    private var mockModels: [TodoModel] = [TodoModel(title: "todo test1",
                                                     body: "todo test1",
                                                     status: .todo,
                                                     date: 1673967757.6580071),
                                           TodoModel(title: "todo test1",
                                                     body: "todo test1\ntodo test1\ntodo test1\ntodo test1",
                                                     status: .todo,
                                                     date: 1673968167.6580071),
                                           TodoModel(title: "doing test1",
                                                     body: "doing test1",
                                                     status: .doing,
                                                     date: 1673967977.6580071),
                                           TodoModel(title: "done test1",
                                                     body: "done test1",
                                                     status: .done,
                                                     date: 1673967754.6580071),
                                           TodoModel(title: "done test1",
                                                     body: "done test1",
                                                     status: .done,
                                                     date: 1673968037.6580071)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureNavagationBar()
        configureListView()
        applyAllSnapshot()
    }
    
    // MARK: - View layout
    private func configureNavagationBar() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
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
    
    private func configureListView() {
        configureTableViews()
        configureLayout()
    }
    
    private func configureTableViews() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        
        tableviews.forEach {
            $0.delegate = self
            tableStackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        self.view.addSubview(tableStackView)
        
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView DataSource and Snapshot
extension ListViewController {
    private func configureDataSource(of tableView: ListTableView) -> UITableViewDiffableDataSource<ListSection, TodoModel> {
        let dataSource = UITableViewDiffableDataSource<ListSection, TodoModel>(tableView: tableView) { tableView, indexPath, todoItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier,
                                                     for: indexPath) as? ListTableViewCell
            
            cell?.configureContent(title: todoItem.title,
                                   body: todoItem.body,
                                   date: todoItem.date.convertDoubleToDate())
            return cell
        }
        return dataSource
    }
    
    private func applyAllSnapshot() {
        applySnapshot(section: ListSection.todo, status: TodoModel.TodoStatus.todo, dataSource: todoDataSource)
        applySnapshot(section: ListSection.doing, status: TodoModel.TodoStatus.doing, dataSource: doingDataSource)
        applySnapshot(section: ListSection.done, status: TodoModel.TodoStatus.done, dataSource: doneDataSource)
    }
    
    private func applySnapshot(section: ListSection,
                               status: TodoModel.TodoStatus,
                               dataSource: UITableViewDiffableDataSource<ListSection, TodoModel>) {
        var snapshot = NSDiffableDataSourceSnapshot<ListSection, TodoModel>()
        snapshot.appendSections([section])
        snapshot.appendItems(mockModels.filter{ $0.status == status })
        dataSource.apply(snapshot)
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
            requestViewUpdate(to: headerView, status: .todo)
        case doingTableView:
            requestViewUpdate(to: headerView, status: .doing)
        case doneTableView:
            requestViewUpdate(to: headerView, status: .done)
        default:
            break
        }
        return headerView
    }
    
    private func requestViewUpdate(to headerView: ListHeaderView, status: TodoModel.TodoStatus) {
        headerView.setTitle(status.rawValue)
        headerView.updateCount(mockModels.filter { $0.status == status }.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellItem = fetchCellItem(from: tableView, indexPath: indexPath) else { return }
        
        let editViewController = EditTodoViewController()
        editViewController.delegate = self
        editViewController.prepareView(with: cellItem)
        
        showTodoItemView(with: cellItem, nextViewController: editViewController)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, completion in
            guard let cellItem = self.fetchCellItem(from: tableView, indexPath: indexPath),
                  let index = self.fetchTodoIndex(cellItem) else { return }
            
            self.mockModels.remove(at: index)
            self.applyAllSnapshot()
            tableView.reloadData()
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    private func fetchCellItem(from tableView: UITableView, indexPath: IndexPath) -> TodoModel? {
        guard let dataSource = tableView.dataSource as? UITableViewDiffableDataSource<ListSection, TodoModel>,
              let todoItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        return todoItem
    }
    
    private func fetchTodoIndex(_ todoItem: TodoModel) -> Int? {
        guard let item = self.mockModels.filter({ $0.id == todoItem.id }).first,
              let index = self.mockModels.firstIndex(of: item) else {
            return nil
        }
        return index
    }
}

// MARK: - AddTodoViewDelegate
extension ListViewController: AddTodoViewDelegate {
    func addNewTodoItem(with item: TodoModel) {
        mockModels.append(item)
        applySnapshot(section: .todo, status: .todo, dataSource: todoDataSource)
        todoTableView.reloadData()
    }
}

// MARK: - EditTodoViewDelegate
extension ListViewController: EditTodoViewDelegate {
    func editTodoItem(with item: TodoModel) {
        guard let index = fetchTodoIndex(item) else { return }
        
        mockModels[index] = item
        applyAllSnapshot()
    }
}
