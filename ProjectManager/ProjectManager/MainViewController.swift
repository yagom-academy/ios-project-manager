//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

enum Section {
    case todo
    case doing
    case done
}

struct TodoLabel: Hashable {
    let title: String
    let content: String
    let date: Date
}

class MainViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private let collectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let user = [TodoLabel(title: "Hi!", content: "Andrew!", date: Date()), TodoLabel(title: "Hello~", content: "Brody!", date: Date())]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        setUpDataSource()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
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
        
        dataSource = UICollectionViewDiffableDataSource<Section, TodoLabel>(collectionView: collectionView) {
            (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: todo)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        snapshot.appendSections([.todo, .doing, .done])
        snapshot.appendItems(user, toSection: .todo)
        snapshot.appendItems(user, toSection: .doing)
        snapshot.appendItems(user, toSection: .done)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
//    private func createLayout() -> UICollectionViewCompositionalLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                             heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .absolute(44))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                       subitems: [item])
//
//        let sectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                 heightDimension: .estimated(200)) // Set an estimated height for the section
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10) // Adjust insets if needed
//
//
//        let numberOfSections = 3
//
//        // Create a nested group to achieve multiple sections horizontally
//        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                     heightDimension: .estimated(200)) // Set an estimated height for the nested group
//
//        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitem: group, count: numberOfSections)
//
//        // Add the nested group to the section
//        section.boundarySupplementaryItems = [
//            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        ]
//
//        // Layout
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
    
    
}
