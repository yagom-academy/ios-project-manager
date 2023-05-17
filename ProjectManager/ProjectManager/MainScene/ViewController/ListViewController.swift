//
//  ListViewController.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/18.
//

import UIKit

final class ListViewController: UIViewController {
    
    private var todoCollectionView: UICollectionView?
    
    private var datasource: UICollectionViewDiffableDataSource<TaskState, Task>?
    private var section: TaskState
    
    init(section: TaskState) {
        self.section = section
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewUI()
        configureCollectionViewUI()
        configureDatasource()
    }

    func applySnapshot(by items: [Task]) {
        var snapshot = NSDiffableDataSourceSnapshot<TaskState, Task>()
        
        snapshot.appendSections([section])
        snapshot.appendItems(items)
        
        datasource?.apply(snapshot, animatingDifferences: true)
    }
}

extension ListViewController {
    private func configureDatasource() {
        guard let collectionView = todoCollectionView else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<TaskListCell, Task> { cell, indexPath, itemIdentifier in
            cell.updateText(by: itemIdentifier)
        }
        
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        todoCollectionView?.dataSource = datasource
    }
}

// MARK: UI
extension ListViewController {
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureCollectionViewUI() {
        let layout = makeCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        todoCollectionView = collectionView
    }
}
