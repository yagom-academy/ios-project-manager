//
//  TodoCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class TodoCollectionViewModel: NSObject, CollectionViewModel {
    enum Section {
        case todo
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Task.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Task.ID>
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var snapshot = Snapshot()
    
    private var cellIdentifier: String
    
    var items: [Task] = []
    
    init(collectionView: UICollectionView?, cellReuseIdentifier: String) {
        self.collectionView = collectionView
        self.cellIdentifier = cellReuseIdentifier
        
        super.init()
    }
    
    func makeDataSource() throws -> DataSource {
        guard let collectionView = collectionView else {
            throw DataSourceError.noneCollectionView
        }
        
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath) as? HeaderView else {
                fatalError("Could not dequeue sectionHeader:")
            }

            sectionHeader.titleLabel.text = "Section Header"
            return sectionHeader
        }
        self.dataSource = dataSource
        
        return dataSource
    }
    
    func updateSnapshot() {
        configureSnapshotItems()
    }
    
    func applyInitialSnapshot() {
        configureSnapshotSection()
        configureSnapshotItems()
        applySnapshot()
    }
    
    func applySnapshot() {
        dataSource?.apply(snapshot)
    }
    
    func updateTask(id: UUID) {
        snapshot.reloadItems([id])
        applySnapshot()
    }
    
    func remove(_ item: Task) {
        self.items.removeAll { $0.id == item.id }
    }
    
    func task(at indexPath: IndexPath) -> Task? {
        return items[safe: indexPath.row]
    }
}

extension TodoCollectionViewModel {
    private func configureSnapshotSection() {
        snapshot.appendSections([.todo])
    }
    
    private func configureSnapshotItems() {
        let taskList = items.map { $0.id }
        snapshot.appendItems(taskList, toSection: .todo)
    }
    
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, identifier: Task.ID) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? TaskCell else {
            return UICollectionViewCell()
        }
        
        guard let task = items.filter({ $0.id == identifier }).first else {
            return UICollectionViewCell()
        }
        
        let taskCellViewModel = TaskCellViewModel(task: task)
        cell.provide(taskCellViewModel)
        
        return cell
    }
}
