//
//  TodoListViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit
import Combine

import SnapKit

final class TodoListViewController: UIViewController {
    private lazy var todoListView = TodoListView(frame: self.view.bounds, tableViewDelegate: self)
    private let viewModel: TodoListViewModelable
    
    private var todoDataSource: TodoListTableViewDataSource?
    private var doingDataSource: TodoListTableViewDataSource?
    private var doneDataSource: TodoListTableViewDataSource?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.todoItems.sink { [weak self] items in
            self?.todoDataSource?.applySnapshot(items: items, datasource: self?.todoDataSource)
            self?.todoListView.setupHeaderTodoCountLabel(with: items.count)
        }
        .store(in: &cancellables)
        
        viewModel.doingItems.sink { [weak self] items in
            self?.doingDataSource?.applySnapshot(items: items, datasource: self?.doingDataSource)
            self?.todoListView.setupHeaderDoingCountLabel(with: items.count)
        }
        .store(in: &cancellables)
        
        viewModel.doneItems.sink { [weak self] items in
            self?.doneDataSource?.applySnapshot(items: items, datasource: self?.doneDataSource)
            self?.todoListView.setupHeaderDoneCountLabel(with: items.count)
        }
        .store(in: &cancellables)
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
        setupDataSource()
    }
    
    private func addSubviews() {
        view.addSubview(todoListView)
    }
    
    private func setupConstraint() {
        todoListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Project Manager"
        
        let addAction = UIAction { [weak self] _ in
            self?.viewModel.addButtonDidTap()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }
    
    private func setupDataSource() {
        todoDataSource = TodoListTableViewDataSource(todoListView.todoTableView)
        doingDataSource = TodoListTableViewDataSource(todoListView.doingTableView)
        doneDataSource = TodoListTableViewDataSource(todoListView.doneTableView)
    }
}

extension TodoListViewController {
    func getViewModel() -> TodoListViewModelable {
        return viewModel
    }
    
    func getTodoListView() -> TodoListView {
        return todoListView
    }
    
    func getTodoDataSource() -> TodoListTableViewDataSource? {
        return todoDataSource
    }
    
    func getDoingDataSource() -> TodoListTableViewDataSource? {
        return doingDataSource
    }
    
    func getDoneDataSource() -> TodoListTableViewDataSource? {
        return doneDataSource
    }
}
