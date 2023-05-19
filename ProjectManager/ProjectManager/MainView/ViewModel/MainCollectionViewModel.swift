//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class MainCollectionViewModel: NSObject {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Todo.ID>
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var cellIdentifier: String
    
    var items: [Todo] = [
        Todo(title: "hi", date: Date(), body: "body", workState: .todo),
        Todo(title: "hiThere", date: Date(), body: "body", workState: .done),
        Todo(title: "hi", date: Date(), body: "body", workState: .doing),
        Todo(title: "hibye", date: Date(), body: "body", workState: .todo),
        Todo(title: "hibyehi", date: Date(), body: "body", workState: .todo)
    ]
    
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

extension MainCollectionViewModel {
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
        self.items.removeAll { $0.id == item.id }
        
        update()
    }
    
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, identifier: Todo.ID) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? TodoCell else {
            return nil
        }
        
        let todo = items.filter { $0.id == identifier }[0]
        let todoViewModel = TodoViewModel(todo: todo)
        
        cell.provide(todoViewModel)
        
        return cell
    }
    
    func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Todo.ID>()
        snapshot.appendSections([.todo, .doing, .done])
        
        let todoList = items.filter { $0.workState == .todo }.map { $0.id }
        let doingList = items.filter { $0.workState == .doing }.map { $0.id }
        let doneList = items.filter { $0.workState == .done }.map { $0.id }
        
        snapshot.appendItems(todoList, toSection: .todo)
        snapshot.appendItems(doingList, toSection: .doing)
        snapshot.appendItems(doneList, toSection: .done)
        dataSource?.apply(snapshot)
    }
}
