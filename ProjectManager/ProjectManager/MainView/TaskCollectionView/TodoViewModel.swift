//
//  TaskCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class TodoViewModel: TaskListViewModel {
    
    @Published var taskList: [Task] = []
    
    var taskWorkState: WorkState
    var delegate: TaskListViewModelDelegate?
    
    init(taskWorkState: WorkState, delegate: TaskListViewModelDelegate? = nil) {
        self.taskWorkState = taskWorkState
        self.delegate = delegate
    }
    
//    init(collectionView: UICollectionView?, cellReuseIdentifier: String) {
//        self.collectionView = collectionView
//        self.cellIdentifier = cellReuseIdentifier
//    }
//
//
//    func updateTask(id: UUID) {
//        guard let dataSource else { return }
//
//        var snapshot = dataSource.snapshot()
//        snapshot.reloadItems([id])
//        dataSource.apply(snapshot)
//    }
//
//    func remove(_ item: Task) {
//        guard let dataSource else { return }
//
//        service.removeTask(id: item.id)
//        var snapshot = dataSource.snapshot()
//        snapshot.deleteItems([item.id])
//        dataSource.apply(snapshot)
//    }
//
//    func task(at indexPath: IndexPath) -> Task? {
//        return items[safe: indexPath.row]
//    }
}

extension TodoViewModel: DetailViewModelDelegate {
    func updateTaskList(for workState: WorkState) {
        
    }
    
    func updateDataSource(for workState: WorkState, itemID: UUID?) {
        
    }
    
    
//    private func updateDataSource() {
//        let taskIDList = items.map { $0.id }
//        var snapshot = Snapshot()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(taskIDList)
//        dataSource?.apply(snapshot)
//    }
//
}

