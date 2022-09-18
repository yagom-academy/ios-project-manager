//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RealmSwift

protocol TodoListViewControllerDelegate: AnyObject {
    func addButtonDidTapped()
    func cellDidTapped(at index: Int, in category: String)
    func cellDidLongPressed<T: ListCollectionView>(
        in view: T,
        location: (x: Double, y: Double),
        item: Todo?
    )
}

final class TodoListViewController: UIViewController {
    
    var viewModel: DefaultTodoListViewModel?
    weak var delegate: TodoListViewControllerDelegate?
    
    var todoListView: ListView
    var doingListView: ListView
    var doneListView: ListView
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 6
        return stackView
    }()
    
    // MARK: - Initializer
    init(viewModel: DefaultTodoListViewModel) {
        self.viewModel = viewModel
        todoListView = ListView(category: Category.todo,
                                viewModel: viewModel)
        doingListView = ListView(category: Category.doing,
                                 viewModel: viewModel)
        doneListView = ListView(category: Category.done,
                                viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupListView()
        placeListView()
        adoptCollectionViewDelegate()
        bindCreateTodo()
        bindHeaderUpdate()
        bindEditTodo()
        bindMoveTodo()
    }
    
    // MARK: - Initial Setup
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTapped)
        )
    }
    
    private func setupListView() {
        todoListView.translatesAutoresizingMaskIntoConstraints = false
        doingListView.translatesAutoresizingMaskIntoConstraints = false
        doneListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todoListView.widthAnchor.constraint(
                equalToConstant: 356
            ),
            doingListView.widthAnchor.constraint(
                equalToConstant: 356
            ),
            doneListView.widthAnchor.constraint(
                equalToConstant: 356
            )
        ])
    }
    
    private func placeListView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoListView)
        stackView.addArrangedSubview(doingListView)
        stackView.addArrangedSubview(doneListView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func adoptCollectionViewDelegate() {
        todoListView.collectionView?.delegate = self
        doingListView.collectionView?.delegate = self
        doneListView.collectionView?.delegate = self
    }
    
    // MARK: - Bind ViewModel
    private func bindCreateTodo() {
        viewModel?.didCreatedTodo = { [weak self] (todo) in
            guard let self = self else { return }
            self.todoListView.collectionView?.add(todo: todo)
        }
    }
    
    private func bindHeaderUpdate() {
        viewModel?.didChangedCount = { [weak self] in
            guard let self = self else { return }
            self.todoListView.headerView?.setupCountLabel(with: Category.todo)
            self.doingListView.headerView?.setupCountLabel(with: Category.doing)
            self.doneListView.headerView?.setupCountLabel(with: Category.done)
        }
    }
    
    private func bindEditTodo() {
        viewModel?.didEditedTodo = {[weak self] (list) in
            guard let self = self else { return }
            switch list.first?.category {
            case Category.todo:
                self.todoListView.collectionView?.update(list)
            case Category.doing:
                self.doingListView.collectionView?.update(list)
            case Category.done:
                self.doneListView.collectionView?.update(list)
            default:
                return
            }
        }
    }
    
    private func bindMoveTodo() {
        viewModel?.didMovedTodo = { [weak self] (list) in
            guard let self = self else { return }
            self.todoListView.collectionView?.update(list[0])
            self.doingListView.collectionView?.update(list[1])
            self.doneListView.collectionView?.update(list[2])
        }
    }
    
    // MARK: - @objc Method
    @objc private func addButtonDidTapped() {
        delegate?.addButtonDidTapped()
    }
}

// MARK: - UICollectionViewDelegate
extension TodoListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
        case todoListView.collectionView:
            delegate?.cellDidTapped(at: indexPath.row,
                                    in: Category.todo)
        case doingListView.collectionView:
            delegate?.cellDidTapped(at: indexPath.row,
                                    in: Category.doing)
        case doneListView.collectionView:
            delegate?.cellDidTapped(at: indexPath.row,
                                    in: Category.done)
        default:
            return
        }
    }
}
