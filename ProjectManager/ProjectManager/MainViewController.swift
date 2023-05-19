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

class MainViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>?
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        setUpDataSource()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
        collectionView.dataSource = dataSource
        
        // register를 따로 하지 않고 register & configure 작업을 할 수 있다
        let todoCellRegistration = UICollectionView.CellRegistration<TodoListCell, String> { (cell, IndexPath, todo) in
            cell.configure(text: todo)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.collectionView) {
            (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: todoCellRegistration, for: indexPath, item: todo)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(["iOS", "Apple", "Banana"])
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
}
