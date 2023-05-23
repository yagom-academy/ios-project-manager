//
//  ListViewController.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/18.
//

import UIKit

final class ListViewController: UIViewController {
    
    private var todoCollectionView: UICollectionView?
    
    private var datasource: UICollectionViewDiffableDataSource<TaskState, Task>?
    private var snapshot = NSDiffableDataSourceSnapshot<TaskState, Task>()
    private var taskState: TaskState
    private let viewModel = ListViewModel()
    
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
        applySnapshot(by: [])
    }
    
    func appendTask(_ task: Task) {
        viewModel.appendTask(task)
        
        applySnapshot(by: [task])
    }

    private func applySnapshot(by items: [Task]) {
        if !snapshot.sectionIdentifiers.contains(taskState) {
            snapshot.appendSections([taskState])
        }
        snapshot.appendItems(items)
        
        datasource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteSnapshot(by task: Task) {
        snapshot.deleteItems([task])
        
        datasource?.apply(snapshot)
    }
}

// MARK: CollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in
            let todoAction = UIAction(title: "Move to Todo") { action in
            }
            let doingAction = UIAction(title: "Move to Doing") { action in
            }
            let doneAction = UIAction(title: "Move to Done") { action in
            }
            
            return UIMenu(options: [.displayInline, .destructive], children: [todoAction, doingAction, doneAction])
        }
    }
}

// MARK: Datasource
extension ListViewController {
    private func configureDatasource() {
        guard let collectionView = todoCollectionView else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<TaskListCell, Task> { cell, indexPath, itemIdentifier in
            cell.updateText(by: itemIdentifier)
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<TaskHeaderView>(elementKind: TaskHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            supplementaryView.updateText(by: self.taskState, number: self.snapshot.numberOfItems)
        }
        
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        datasource?.supplementaryViewProvider = { (view, kind, index) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
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
            var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            
            listConfig.trailingSwipeActionsConfigurationProvider = { indexPath in
                let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
                    // Delete Item
                    completion(true)
                }
                
                deleteAction.backgroundColor = .systemRed
                
                return UISwipeActionsConfiguration(actions: [deleteAction])
            }
            
            let section = NSCollectionLayoutSection.list(using: listConfig, layoutEnvironment: layoutEnvironment)
            let headerViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(100))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerViewSize, elementKind: TaskHeaderView.identifier, alignment: .top)
            
            section.interGroupSpacing = 10
            section.boundarySupplementaryItems = [header]
            
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
        todoCollectionView?.delegate = self
    }
}
