//
//  ListViewController.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/18.
//

import UIKit

final class ListViewController: UIViewController {
    
    private var todoCollectionView: UICollectionView?
    
    private var datasource: UICollectionViewDiffableDataSource<Int, Task>?
    private var snapshot = NSDiffableDataSourceSnapshot<Int, Task>()
    private var sectionIndex = 0
    private var taskState: TaskState
    
    init(taskState: TaskState) {
        self.taskState = taskState
        
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

    func applySnapshot(by item: Task) {
        snapshot.appendSections([sectionIndex])
        snapshot.appendItems([item])
        
        sectionIndex += 1
        
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
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            let section = NSCollectionLayoutSection.list(using: listConfig, layoutEnvironment: layoutEnvironment)
            
            section.contentInsets.bottom = 3
            
            return section
        }
        
        return layout
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
