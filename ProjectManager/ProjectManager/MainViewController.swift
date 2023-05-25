//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

enum Section {
    case main
}

struct TodoLabel: Hashable {
    let title: String
    let content: String
    let date: Date
}

class MainViewController: UIViewController {
    private var dataSource1: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private var dataSource2: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private var dataSource3: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private let collectionView1 = CustomCollectionView()
    private let collectionView2 = CustomCollectionView()
    private let collectionView3 = CustomCollectionView()
    private lazy var mainStackView = {
        let stackView = UIStackView(arrangedSubviews: [collectionView1, collectionView2, collectionView3])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let user = [TodoLabel(title: "Hi!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!", content: "Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!", date: Date()), TodoLabel(title: "Hello~", content: "Brody!", date: Date())]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        setUpDataSource()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(-50)
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    @objc private func didTapAddButton() {
        modalPresentationStyle = .fullScreen
        present(PopupViewController(), animated: true)
    }
}

// MARK: UICollectionViewDiffableDataSource, CompositionalLayoutConfiguration
extension MainViewController {
    private func setUpDataSource() {
        let registration = UICollectionView.CellRegistration<TodoListCell, TodoLabel> { cell, IndexPath, todo in
            cell.configure(title: todo.title, content: todo.content, date: todo.date)
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <Header>(elementKind: UICollectionView.elementKindSectionHeader) {
            (headerView, elementKind, indexPath) in
            let headerItem = self.dataSource1?.snapshot().sectionIdentifiers[indexPath.section]
//            let headerItem = self.dataSource1?.snapshot().sectionIdentifiers[indexPath.section]
            headerView.headerLabel.text = "TODO"
            headerView.cellCountLabel.text = "1"
        }
        
        let headerRegistration1 = UICollectionView.SupplementaryRegistration
        <Header>(elementKind: UICollectionView.elementKindSectionHeader) {
            (headerView, elementKind, indexPath) in
//            let headerItem = self.dataSource1?.snapshot().sectionIdentifiers[indexPath.section]
            headerView.headerLabel.text = "DOING"
            headerView.cellCountLabel.text = "2"
        }
        
        dataSource1 = UICollectionViewDiffableDataSource<Section, TodoLabel>(collectionView: collectionView1) {
            (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: todo)
        }
        
        dataSource1?.supplementaryViewProvider = {
            (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return self.collectionView1.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath)
        }
        
        dataSource2 = UICollectionViewDiffableDataSource<Section, TodoLabel>(collectionView: collectionView2) {
            (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: todo)
        }
        
        dataSource2?.supplementaryViewProvider = {
            (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return self.collectionView2.dequeueConfiguredReusableSupplementary(
                using: headerRegistration1, for: indexPath)
        }
        
        dataSource3 = UICollectionViewDiffableDataSource<Section, TodoLabel>(collectionView: collectionView3) {
            (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: todo)
        }
        
        dataSource3?.supplementaryViewProvider = {
            (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return self.collectionView3.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(user, toSection: .main)
        dataSource1?.apply(snapshot, animatingDifferences: true)
        dataSource2?.apply(snapshot, animatingDifferences: true)
        dataSource3?.apply(snapshot, animatingDifferences: true)
    }
}
