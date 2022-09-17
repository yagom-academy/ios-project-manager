//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class TodoListViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    private var viewModel: TodoListViewModel?
    private var todoListView: ListView?
    private var doingListView: ListView?
    private var doneListView: ListView?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 6
        return stackView
    }()
    
    // MARK: - Initializer
    init(viewModel: TodoListViewModel) {
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
        setupListView()
        placeListView()
        bind()
    }
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
    
    // MARK: - Bind Methods
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
