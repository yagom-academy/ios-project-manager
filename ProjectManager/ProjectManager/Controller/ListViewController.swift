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
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ListSection, TodoModel>
    
    private typealias DataSource = UITableViewDiffableDataSource<ListSection, TodoModel>
    
    private lazy var todoDataSource: DataSource = configureDataSource(of: todoTableView)
    private lazy var doingDataSource: DataSource = configureDataSource(of: doingTableView)
    private lazy var doneDataSource: DataSource = configureDataSource(of: doneTableView)
    
    // 테스트용 todoModels
    private var todoModels: [TodoModel] = [TodoModel(title: "todo test1",
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
    
    // MARK: - configure view layout
    private func configureNavagationBar() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(tappedAddButton))
    }
    
    @objc private func tappedAddButton() {
        let newTodoItem = TodoModel()
        
        let rootViewController = AddTodoViewController()
        rootViewController.delegate = self
        
        showTodoItemView(with: newTodoItem, rootViewController: rootViewController)
    }
    
    private func showTodoItemView(with todoItem: TodoModel, rootViewController: UIViewController) {
        let nextViewController = UINavigationController(rootViewController: rootViewController)
        nextViewController.modalPresentationStyle = .formSheet
        nextViewController.preferredContentSize = CGSize(width: 650, height: 650)
        
        present(nextViewController, animated: true)
    }
    
    private func configureListView() {
        configureTableViews()
        configureLayout()
    }
    
    private func configureTableViews() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        
        tableviews.forEach {
            $0.delegate = self
            $0.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
            $0.register(ListHeaderView.self, forHeaderFooterViewReuseIdentifier: ListHeaderView.identifier)
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
    
    // MARK: - configure dataSource and snapshot of tableViews
    private func configureDataSource(of tableView: ListTableView) -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, todoItem in
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
    
    private func applySnapshot(section: ListSection, status: TodoModel.TodoStatus, dataSource: DataSource) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(todoModels.filter{ $0.status == status })
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
        headerView.setTitleLabel(with: status.rawValue)
        headerView.updateCount(todoModels.filter { $0.status == status }.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemDataSource = tableView.dataSource as? DataSource,
              let todoItem = itemDataSource.itemIdentifier(for: indexPath) else { return }
        
        let rootViewController = EditTodoViewController()
        rootViewController.delegate = self
        rootViewController.prepareEditView(with: todoItem)
        
        showTodoItemView(with: todoItem, rootViewController: rootViewController)
    }
}

// MARK: - AddTodoViewDelegate
extension ListViewController: AddTodoViewDelegate {
    func addNewTodoItem(with item: TodoModel) {
        todoModels.append(item)
        applySnapshot(section: .todo, status: .todo, dataSource: todoDataSource)
        todoTableView.reloadData()
    }
}

// MARK: - EditTodoViewDelegate
extension ListViewController: EditTodoViewDelegate {
    func editTodoItem(with item: TodoModel) {
        guard let itemBeEdited = todoModels.filter({ $0.id == item.id }).first,
              let index = todoModels.firstIndex(of: itemBeEdited) else { return }
        
        todoModels[index] = item
        applyAllSnapshot()
    }
}
