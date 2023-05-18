//
//  TaskListViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

final class TaskListViewController: UIViewController {
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Task>
    
    private var dataSource: DataSource?
    private let viewModel = TaskListViewModel()
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createListLayout())
        
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TaskListCell.self,
                                forCellWithReuseIdentifier: TaskListCell.identifier)
        collectionView.register(TaskListHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TaskListHeaderView.identifier)
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupCollectionViewConstraints()
        setupCollectionView()
    }
    
    private func setupCollectionViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func setupCollectionView() {
        setupDataSource()
        setupInitailSnapshot()
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, task in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskListCell.identifier,
                for: indexPath
            ) as? TaskListCell else { return UICollectionViewCell() }
            
            cell.configure(task)
            
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TaskListHeaderView.identifier,
                for: indexPath
            ) as? TaskListHeaderView else {
                return nil
            }
            
            header.label.text = "TODO"
            
            return header
        }
    }
    
    private func setupInitailSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Task>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.taskList)
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
