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
    
    private var todoDataSource: UICollectionViewDiffableDataSource<Section, TodoModel>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, TodoModel>()
    private var viewModel: TodoListViewModel?
    private var currentLongPressedCell: ListCell?
    var category: Category?
    
    // MARK: Initializer
    init(frame: CGRect, category: Category?, viewModel: TodoListViewModel?) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        self.viewModel = viewModel
        self.category = category
        delegate = self
        setupInitialView()
        configureDataSource(with: viewModel?.read(category))
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
    
    private func trailingSwipeActionConfigurationForListCellItem(_ item: TodoModel) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { [weak self] (_, _, completion) in
            guard let self = self else {
                completion(false)
                return
            }
            self.delete([item])
            self.viewModel?.delete(model: item)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func configureDataSource(with data: [TodoModel]?) {
        guard let data = data else { return }
        let cellRegistration = UICollectionView.CellRegistration<ListCell, TodoModel> { (cell, _, todo) in
            cell.setup(with: todo)
        }
        todoDataSource = UICollectionViewDiffableDataSource<Section, TodoModel>(collectionView: self) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: TodoModel) -> UICollectionViewCell? in
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
    
    func delete(_ item: [TodoModel]) {
        snapshot.deleteItems(item)
        todoDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func add(_ item: [TodoModel]) {
        snapshot.appendItems(item)
        todoDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func update(_ items: [TodoModel]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        todoDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - CollectionView Delegate
extension ListCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel?.read(category)?[indexPath.row] else { return }
        viewModel?.goToEdit(model)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ListCollectionView: UIGestureRecognizerDelegate {
    
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer:))
        )
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        addGestureRecognizer(longPressedGesture)
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: self)
        let state = gestureRecognizer.state
        switch state {
        case .began:
            animateLongPressBegin(at: location)
        case .ended:
            animateLongPressEnd(at: location)
        default:
            return
        }
    }
    
    private func animateLongPressBegin(at location: CGPoint) {
        guard let indexPath = indexPathForItem(at: location) else { return }
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            guard let cell = self.cellForItem(at: indexPath) as? ListCell else { return }
            self.currentLongPressedCell = cell
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func animateLongPressEnd(at location: CGPoint) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            guard let cell = self.currentLongPressedCell else { return }
            cell.transform = .init(scaleX: 1, y: 1)
            guard let indexPath = self.indexPathForItem(at: location) else { return }
            guard cell == self.cellForItem(at: indexPath) as? ListCell else { return }
            self.viewModel?.showPopover(
                in: self,
                location: (Double(location.x), Double(location.y)),
                indexPath: indexPath.row
            )
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension ListCollectionView: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
