//
//  ListView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/11.
//

import UIKit

final class ListView: UIView {
    private var headerView: HeaderView?
    private var collectionView: ListCollectionView?
    private var viewModel: TodoListViewModel?
    private var category: Category?
    
    init(viewModel: TodoListViewModel?, category: Category) {
        super.init(frame: .zero)
        guard let viewModel = viewModel else { return }
        
        self.viewModel = viewModel
        self.category = category
        setupInitialView()
        setupHeaderView(category: category)
        setupCollectionView(
            category: category,
            viewModel: viewModel
        )
        placeCollectionView()
        placeHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialView() {
        backgroundColor = .systemGray6
    }
    
    private func setupHeaderView(category: Category?) {
        guard let category = category else { return }
        headerView = HeaderView(
            with: Header(
                category: category,
                count: 0
            )
        )
        headerView?.backgroundColor = .systemGray6
    }
    
    private func setupCollectionView(category: Category?,
                                     viewModel: TodoListViewModel) {
        collectionView = ListCollectionView(
            frame: .zero,
            category: category,
            viewModel: viewModel
        )
    }
    
    private func placeHeaderView() {
        guard let headerView = headerView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            headerView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 70
            ),
            headerView.widthAnchor.constraint(
                equalToConstant: 355
            ),
            headerView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            )
        ])
    }
    
    private func placeCollectionView() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 70
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            )
        ])
    }
    
    func refreshHeader() {
        guard let numberOfRows = viewModel?.read(category)?.count else { return }
        headerView?.updateCount(number: numberOfRows)
    }
    
    func add(item: [TodoModel]) {
        collectionView?.add(item)
    }
    
    func delete(item: [TodoModel]) {
        collectionView?.delete(item)
    }
    
    func update() {
        guard let items = viewModel?.read(category) else { return }
        collectionView?.update(items)
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }
}
