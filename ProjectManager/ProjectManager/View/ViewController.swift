//
//  ProjectManager - ViewController.swift
//  Created by 수꿍, 휴 on 2022/09/07.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private enum Section: String {
        case toDo = "ToDo"
        case doing = "Doing"
        case done = "Done"
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ProjectUnit>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ProjectUnit>
    private var collectionView: UICollectionView?
    private var dataSource: DataSource?
//    private var snapShot: Snapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        configureCollectionView()
        
        configureDataSource()
        configureSnapshot()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        
        guard let collectionView = collectionView else {
            return
        }

        collectionView.isScrollEnabled = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
    
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CollectionViewCell, ProjectUnit> { (cell, indexPath, item) in
            print(indexPath)
            print(indexPath.section)
            switch (indexPath.section, indexPath.row) {
            case (0, 0):
                cell.backgroundColor = .red
            case (1, 0):
                cell.backgroundColor = .blue
            case (2, 0):
                cell.backgroundColor = .green
            default:
                cell.backgroundColor = .systemBackground
                
            }
        }
        
        guard let collectionView = collectionView else {
            return
        }

        dataSource = UICollectionViewDiffableDataSource<Section, ProjectUnit>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        })
    }
    
    private func configureSnapshot() {
        var snapshot = Snapshot()
        
        let unit = ProjectUnit(id: UUID(), title: "쥬스 메이커", body: "쥬스 메이커 프로젝트입니다", section: Section.toDo.rawValue, deadLine: Date())
        
        snapshot.appendSections([.toDo, .doing, .done])
        snapshot.appendItems([unit])
        
        
        dataSource?.apply(snapshot)
    }
}
