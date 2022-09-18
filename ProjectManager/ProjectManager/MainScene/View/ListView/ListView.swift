//
//  ListView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/11.
//

import UIKit

final class ListView: UIView {
    private var category: String
    var headerView: HeaderView?
    var collectionView: ListCollectionView?
    var viewModel: DefaultTodoListViewModel
    
    // MARK: - Initializer
    init(category: String, viewModel: DefaultTodoListViewModel) {
        self.category = category
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupInitialView()
        setupHeaderView(category: category)
        setupCollectionView(category: category)
        placeCollectionView()
        placeHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupInitialView() {
        backgroundColor = .systemGray6
    }
    
    private func setupHeaderView(category: String) {
        headerView = HeaderView(category: category,
                                viewModel: viewModel)
        headerView?.backgroundColor = .systemGray6
    }
    
    private func setupCollectionView(category: String) {
        collectionView = ListCollectionView(category: category,
                                            viewModel: viewModel)
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
}
