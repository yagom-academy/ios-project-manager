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
    private func configureCellRegistration() -> UICollectionView.CellRegistration<TodoListCell, TodoLabel> {
        return UICollectionView.CellRegistration<TodoListCell, TodoLabel> { cell, IndexPath, todo in
            cell.configure(title: todo.title, content: todo.content, date: todo.date)
        }
    }

    private func configureHeaderRegistration(headerText: String) -> UICollectionView.SupplementaryRegistration<Header> {
        return UICollectionView.SupplementaryRegistration<Header>(elementKind: UICollectionView.elementKindSectionHeader) { (headerView, _, _) in
            headerView.headerLabel.text = headerText
            headerView.cellCountLabel.text = "1"
        }
    }
    
    private func configureDataSource(collectionView: UICollectionView, registration: UICollectionView.CellRegistration<TodoListCell, TodoLabel>, headerRegistration: UICollectionView.SupplementaryRegistration<Header>) -> UICollectionViewDiffableDataSource<Section, TodoLabel> {
        let dataSource = UICollectionViewDiffableDataSource<Section, TodoLabel>(collectionView: collectionView) { (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: todo)
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        return dataSource
    }

    private func setUpDataSource() {
        let registration = configureCellRegistration()
        let headerRegistration1 = configureHeaderRegistration(headerText: "TODO")
        let headerRegistration2 = configureHeaderRegistration(headerText: "DOING")
        let headerRegistration3 = configureHeaderRegistration(headerText: "DONE")

        dataSource1 = configureDataSource(collectionView: collectionView1, registration: registration, headerRegistration: headerRegistration1)
        dataSource2 = configureDataSource(collectionView: collectionView2, registration: registration, headerRegistration: headerRegistration2)
        dataSource3 = configureDataSource(collectionView: collectionView3, registration: registration, headerRegistration: headerRegistration3)

        var snapshot = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(user, toSection: .main)

        dataSource1?.apply(snapshot, animatingDifferences: true)
        dataSource2?.apply(snapshot, animatingDifferences: true)
        dataSource3?.apply(snapshot, animatingDifferences: true)
    }
}
