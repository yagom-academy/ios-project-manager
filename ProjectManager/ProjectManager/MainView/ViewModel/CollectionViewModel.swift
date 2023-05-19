//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class CollectionViewModel: NSObject {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Todo>
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var cellIdentifier: String
    
    var items: [Todo] = []
    
    init(collectionView: UICollectionView?, cellReuseIdentifier: String) {
        self.collectionView = collectionView
        self.cellIdentifier = cellReuseIdentifier
        super.init()
    }
    
    enum Section {
        case todo
        case doing
        case done
    }
}

extension CollectionViewModel {
    func makeDataSource() throws -> DataSource {
        guard let collectionView = collectionView else {
            throw DataSourceError.noneCollectionView
        }
        
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        self.dataSource = dataSource
        
        return dataSource
    }
    
    func add(_ item: Todo) {
        self.items.append(item)
    
        update()
    }
    
    func remove(_ item: Todo) {
        self.items.removeAll { $0 == item }
        
        update()
    }
    
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, item: Todo) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? TodoCell else {
            return nil
        }
        
        let todoViewModel = TodoViewModel(todo: item)
        
        cell.provide(todoViewModel)
        
        return cell
    }
    
    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Todo>()
        snapshot.appendSections([.todo, .doing, .done])
        
        let todoList = items.filter { $0.workState == .todo }
        let doingList = items.filter { $0.workState == .doing }
        let doneList = items.filter { $0.workState == .done }
        
        snapshot.appendItems(todoList, toSection: .todo)
        snapshot.appendItems(doingList, toSection: .doing)
        snapshot.appendItems(doneList, toSection: .done)
        dataSource?.apply(snapshot)
    }
}
