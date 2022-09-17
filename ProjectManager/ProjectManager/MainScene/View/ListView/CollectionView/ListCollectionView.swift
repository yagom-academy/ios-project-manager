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
    var category: String
    var viewModel: TodoListViewModel
    var currentLongPressedCell: ListCell?
    
    // MARK: Initializer
    init(category: String, viewModel: TodoListViewModel) {
        self.category = category
        self.viewModel = viewModel
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        setupInitialView()
        configureDataSource(with: viewModel.fetchTodoList(in: category))
        setupLongGestureRecognizerOnCollection()
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
            guard let self = self else {
                completion(false)
                return
            }
            self.delete(todo: item)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func configureDataSource(with data: [Todo]?) {
        guard let data = data else { return }
        let cellRegistration = UICollectionView.CellRegistration<ListCell, Todo> { (cell, _, todo) in
            cell.setup(with: todo)
        }
        todoDataSource = UICollectionViewDiffableDataSource<Section, Todo>(collectionView: self) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        todoDataSource?.apply(snapshot)
    }
    
    func add(todo: Todo) {
        snapshot.appendItems([todo], toSection: .main)
        todoDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func delete(todo: Todo) {
        snapshot.deleteItems([todo])
        todoDataSource?.apply(snapshot, animatingDifferences: true)
        viewModel.delete(todo: todo)
    }
    
    func update(_ items: [Todo]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        todoDataSource?.apply(snapshot, animatingDifferences: true)
    }
}
