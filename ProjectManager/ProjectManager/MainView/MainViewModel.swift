//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Foundation

final class MainViewModel {
    var taskList: [Task] = []
    var viewModelDictionary: [WorkState: TaskListViewModel] = [:]
    private let service: TaskStorageService
    
    init(service: TaskStorageService) {
        self.service = service
    }
    
    func assignChildViewModel(of children: [TaskListViewModel]) {
        children
            .forEach {
                $0.delegate = self
                viewModelDictionary[$0.taskWorkState] = $0
            }
    }
    
    func fetchTaskList() {
        taskList = service.fetchTaskList()
    }
    
    func distributeTask() {
        viewModelDictionary.forEach { workState, viewModel in
            let filteredTaskList = taskList.filter { $0.workState == workState }
            viewModel.taskList = filteredTaskList
        }
    }
    
    func todoViewModel() -> TaskListViewModel? {
        return viewModelDictionary[.todo]
    }
}

extension MainViewModel: TaskListViewModelDelegate {
    func createTask(_ task: Task) {
        service.createTask(task)
    }
    
    func updateTask(_ task: Task) {
        service.updateTask(task)
    }
    
    func deleteTask(id: UUID) {
        service.deleteTask(id: id)
    }
}

extension MainViewModel: ChangeWorkStateViewModelDelegate {
    func changeWorkState(taskID: UUID, with workState: WorkState) {
        service.changeWorkState(taskID: taskID, with: workState)
        fetchTaskList()
        distributeTask()
    }
}
