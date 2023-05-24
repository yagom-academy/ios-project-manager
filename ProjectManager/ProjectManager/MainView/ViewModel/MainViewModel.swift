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
    
    func fetchTaskList() {
        taskList = mainCollectionViewService.fetchTaskList()
        distributeTask()
        applyTask()
    }
    
    private func distributeTask() {
        viewModelDictionary.forEach { workState, viewModel in
            let taskList = taskList.filter { $0.workState == workState }
            viewModel.items = taskList
        }
    }
    
    private func applyTask() {
        viewModelDictionary.forEach { _, viewModel in
            viewModel.applyInitialSnapshot()
        }
    }
}
