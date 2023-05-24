//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import UIKit

final class MainViewModel {
    private let mainCollectionViewService = MainCollectionViewService()
    
    var taskList: [Task] = []
    var viewModelDictionary = [WorkState: any CollectionViewModel]()
    
    func assignChildViewModel(of children: [UIViewController]) {
        children.forEach {
            if let collectionViewController = $0 as? TaskCollectionViewController {
                self.viewModelDictionary[collectionViewController.mode] = collectionViewController.viewModel
            }
        }
    }
    
    func configureCollectionViewModels() {
        fetchTaskList()
        distributeTask()
    }
    
    func updateCollectionViewModel(workState: WorkState, itemID: UUID?) {
        guard let itemID else { return }
        
        let viewModel = viewModelDictionary[workState]
        viewModel?.updateTask(id: itemID)
    }
    
    private func fetchTaskList() {
        taskList = mainCollectionViewService.fetchTaskList()
    }
    
    private func distributeTask() {
        viewModelDictionary.forEach { workState, viewModel in
            let taskList = taskList.filter { $0.workState == workState }
            viewModel.items = taskList
        }
    }
}
