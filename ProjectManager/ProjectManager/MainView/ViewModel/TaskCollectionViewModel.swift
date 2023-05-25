//
//  TaskCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class TaskCollectionViewModel: CollectionViewModel {
    enum Section {
        case main
    }
    
    typealias Item = Task
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Task.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Task.ID>
    
    private let service = CollectionTaskService()
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var cellIdentifier: String
    
    var items: [Task] = [] {
        didSet {
            updateDataSource()
        }
    }
    
    init(collectionView: UICollectionView?, cellReuseIdentifier: String) {
        self.collectionView = collectionView
        self.cellIdentifier = cellReuseIdentifier
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
    
    func updateTask(id: UUID) {
        guard let dataSource else { return }
        
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([id])
        dataSource.apply(snapshot)
    }
    
    func remove(_ item: Task) {
        guard let dataSource else { return }
        
        service.removeTask(id: item.id)
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([item.id])
        dataSource.apply(snapshot)
    }
    
    func task(at indexPath: IndexPath) -> Task? {
        return items[safe: indexPath.row]
    }
}

extension TaskCollectionViewModel {
    private func updateDataSource() {
        let taskIDList = items.map { $0.id }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(taskIDList)
        dataSource?.apply(snapshot)
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

