//
//  DoingCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class DoingCollectionViewModel: NSObject {
    enum Section {
        case todo
        case doing
        case done
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Task.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Task.ID>
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var snapshot = Snapshot()
    
    private var cellIdentifier: String
    private let mainCollectionViewService = MainCollectionViewService()
    
    var items: [Task] = []
    
    init(collectionView: UICollectionView?, cellReuseIdentifier: String) {
        self.collectionView = collectionView
        self.cellIdentifier = cellReuseIdentifier
        
        super.init()
        fetchTaskList()
        configureSnapshotSection()
        configureSnapshotItems()
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
        fetchTaskList()
        configureSnapshotItems()
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
        var targetList = [Task]()
        
        switch indexPath.section {
        case 0:
            targetList = items.filter { $0.workState == .todo }
        case 1:
            targetList = items.filter { $0.workState == .doing }
        case 2:
            targetList = items.filter { $0.workState == .done }
        default:
            break
        }
        
        return targetList[safe: indexPath.row]
    }
}

extension DoingCollectionViewModel {
    private func fetchTaskList() {
        items = mainCollectionViewService.fetchTaskList()
    }
    
    private func configureSnapshotSection() {
        snapshot.appendSections([.todo, .doing, .done])
    }
    
    private func configureSnapshotItems() {
        let todoList = items.filter { $0.workState == .todo }.map { $0.id }
        let doingList = items.filter { $0.workState == .doing }.map { $0.id }
        let doneList = items.filter { $0.workState == .done }.map { $0.id }
        
        snapshot.appendItems(todoList, toSection: .todo)
        snapshot.appendItems(doingList, toSection: .doing)
        snapshot.appendItems(doneList, toSection: .done)
    }
    
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, identifier: Task.ID) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? TaskCell else {
            return UICollectionViewCell()
        }
        
        guard let task = items.filter { $0.id == identifier }[safe: 0] else {
            return UICollectionViewCell()
        }
        let taskViewModel = TaskCellViewModel(task: task)
        
        cell.provide(taskViewModel)
        
        return cell
    }
}

extension DoingCollectionViewModel: CollectionViewModel {
    func applyInitialSnapshot() {
        
    }
}
