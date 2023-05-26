//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import UIKit

final class MainViewModel {
    private let mainTaskService = MainTaskService()
    
    var taskList: [Task] = []
    var viewModelDictionary = [WorkState: TaskCollectionViewModel]()
    
    func assignChildViewModel(of children: [UIViewController]) {
        children.forEach {
            if let collectionViewController = $0 as? TaskCollectionViewController {
                self.viewModelDictionary[collectionViewController.mode] = collectionViewController.viewModel
            }
        }
    }
    
    func configureDataSource() {
        fetchTaskList()
        distributeTask()
    }
    
    func updateTaskList(for workState: WorkState) {
        let taskList = mainTaskService.fetchTaskList(for: workState)
        let collectionViewModel = viewModelDictionary[workState]
        collectionViewModel?.items = taskList
    }
    
    func updateDataSource(for workState: WorkState, itemID: UUID?) {
        guard let itemID else { return }
        
        let viewModel = viewModelDictionary[workState]
        viewModel?.updateTask(id: itemID)
    }
    
    private func fetchTaskList() {
        taskList = mainTaskService.fetchTaskList()
    }
    
    private func distributeTask() {
        viewModelDictionary.forEach { workState, viewModel in
            let taskList = taskList.filter { $0.workState == workState }
            viewModel.items = taskList
        }
    }
}

extension MainViewModel: DetailViewControllerDelegate { }
