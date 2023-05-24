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
    
    private func fetchTaskList() {
        taskList = mainCollectionViewService.fetchTaskList()
    }
    
    private func distributeTask() {
        guard let todoCollectionViewModel = viewModelDictionary[.todo],
              let doingCollectionViewModel = viewModelDictionary[.doing],
              let doneCollectionViewModel = viewModelDictionary[.doing] else {
            return
        }
        
        let todoTaskList = taskList.filter { $0.workState == .todo }
        let doingTaskList = taskList.filter { $0.workState == .doing }
        let doneTaskList = taskList.filter { $0.workState == .done }
        
        todoCollectionViewModel.items = todoTaskList
        doingCollectionViewModel.items = doingTaskList
        doneCollectionViewModel.items = doneTaskList
    }
}
