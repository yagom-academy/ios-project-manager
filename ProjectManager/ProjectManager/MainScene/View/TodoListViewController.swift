//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class TodoListViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    private var viewModel: TodoListViewModel?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 6
        return stackView
    }()
    private var todoListView: ListView?
    private var doingListView: ListView?
    private var doneListView: ListView?
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupListView()
        placeListView()
        bind()
    }
    
    static func create(with viewModel: TodoListViewModel,
                       coordinator: AppCoordinator) -> TodoListViewController {
        let viewController = TodoListViewController()
        viewModel.coordinator = coordinator
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupListView() {
        guard let viewModel = viewModel else { return }
        todoListView = ListView(
            viewModel: viewModel,
            category: .todo
        )
        doingListView = ListView(
            viewModel: viewModel,
            category: .doing
        )
        doneListView = ListView(
            viewModel: viewModel,
            category: .done
        )
        guard let todoListView = todoListView,
              let doingListView = doingListView,
              let doneListView = doneListView else {
            return
        }
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
        guard let todoListView = todoListView,
              let doingListView = doingListView,
              let doneListView = doneListView else {
            return
        }
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
    
    private func bind() {
        didCreatedItem()
        didDeletedItem()
        didUpdateItem()
    }
    
    private func didCreatedItem() {
        viewModel?.didCreatedItem = { [weak self] (item) in
            guard let self = self else { return }
            switch item.category {
            case .todo:
                self.todoListView?.add(item: [item])
                self.todoListView?.refreshHeader()
            case .doing:
                self.doingListView?.add(item: [item])
                self.doingListView?.refreshHeader()
            case .done:
                self.doneListView?.add(item: [item])
                self.doneListView?.refreshHeader()
            }
        }
    }
    
    private func didDeletedItem() {
        viewModel?.didDeletedItem = { [weak self] (item) in
            guard let self = self else { return }
            switch item.category {
            case .todo:
                self.todoListView?.delete(item: [item])
                self.todoListView?.refreshHeader()
            case .doing:
                self.doingListView?.delete(item: [item])
                self.doingListView?.refreshHeader()
            case .done:
                self.doneListView?.delete(item: [item])
                self.doneListView?.refreshHeader()
            }
        }
    }
    
    private func didUpdateItem() {
        viewModel?.didUpdateItem = { [weak self] (item) in
            guard let self = self else { return }
            switch item.category {
            case .todo:
                self.todoListView?.update()
                self.todoListView?.reloadData()
            case .doing:
                self.doingListView?.update()
                self.doingListView?.reloadData()
            case .done:
                self.doneListView?.update()
                self.doneListView?.reloadData()
            }
        }
    }
}
