//
//  ListView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/11.
//

import UIKit

final class ListView: UIView {
    private let category: String
    let headerView: HeaderView
    let collectionView: ListCollectionView
    
    // MARK: - Initializer
    init(category: String) {
        self.category = category
        self.headerView = HeaderView(category: category)
        self.collectionView = ListCollectionView(category: category)
        super.init(frame: .zero)
        setupInitialView()
        setupHeaderView(category: category)
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
        headerView.backgroundColor = .systemGray6
    }
    
    private func placeHeaderView() {
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
