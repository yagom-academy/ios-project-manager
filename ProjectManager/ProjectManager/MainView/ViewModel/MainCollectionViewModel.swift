//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class MainCollectionViewModel: NSObject {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Task.ID>
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var cellIdentifier: String
    
    var items: [Task] = [
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hiThere", date: Date(), body: "body", workState: .done),
        Task(title: "hi", date: Date(), body: "body", workState: .doing),
        Task(title: "hibye", date: Date(), body: "body", workState: .todo),
        Task(title: "hibyehi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "bodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybodybody", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo),
        Task(title: "hi", date: Date(), body: "body", workState: .todo)
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
    
    func add(_ item: Task) {
        self.items.append(item)
    
        update()
    }
    
    func remove(_ item: Task) {
        self.items.removeAll { $0.id == item.id }
        
        update()
    }
    
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, identifier: Task.ID) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath
        ) as? TaskCell else {
            return nil
        }
        
        let task = items.filter { $0.id == identifier }[0]
        let taskViewModel = TaskViewModel(task: task)
        
        cell.provide(taskViewModel)
        
        return cell
    }
    
    func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Task.ID>()
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
