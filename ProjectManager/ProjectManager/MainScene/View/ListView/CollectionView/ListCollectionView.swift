//
//  ListCollectionView.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class ListCollectionView: UICollectionView {
    
    private enum Section {
        case main
    }

    weak var transitionDelegate: TodoListViewControllerDelegate?
    private var todoDataSource: UICollectionViewDiffableDataSource<Section, Todo>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Todo>()
    let viewModel: ListCollectionViewModel
    var currentLongPressedCell: ListCell?
    
    // MARK: Initializer
    init(viewModel: ListCollectionViewModel,
         delegate: TodoListViewControllerDelegate?) {
        self.viewModel = viewModel
        transitionDelegate = delegate
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        setupInitialView()
        configureDataSource()
        setupDataSource(with: viewModel.fetchList())
        setupLongGestureRecognizerOnCollection()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCollectionView {
 
    private func setupInitialView() {
        showsVerticalScrollIndicator = false
        setCollectionViewLayout(createListLayout(), animated: false)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .systemGray6
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let sectionProvider = { (_: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.trailingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
                guard let self = self else { return nil }
                guard let item = self.todoDataSource?.itemIdentifier(for: indexPath) else { return nil }
                return self.trailingSwipeActionConfigurationForListCellItem(item)
            }
            section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
            section.interGroupSpacing = 10
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func trailingSwipeActionConfigurationForListCellItem(_ item: Todo) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { [weak self] (_, _, completion) in
            self?.viewModel.delete(todo: item)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListCell, Todo> { (cell, _, todo) in
            cell.setupData(with: todo)
        }
        todoDataSource = UICollectionViewDiffableDataSource<Section, Todo>(collectionView: self) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
    private func setupDataSource(with items: [Todo]?) {
        guard let items = items else { return }
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        todoDataSource?.apply(snapshot, animatingDifferences: true)
    }
   
    // MARK: - Bind
    private func bindUI() {
        viewModel.bindList { [weak self] (list) in
            self?.setupDataSource(with: list)
        }
    }
}
