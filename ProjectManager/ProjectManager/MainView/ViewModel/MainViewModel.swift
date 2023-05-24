//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

final class MainViewModel {
    
    private let mainCollectionViewService = MainCollectionViewService()
    
    var taskList: [Task] = []
    var todoCollectionViewModel: TodoCollectionViewModel?
    var doingCollectionViewModel: DoingCollectionViewModel?
    var doneCollectionViewModel: DoneCollectionViewModel?
    
    private func fetchTaskList() {
        taskList = mainCollectionViewService.fetchTaskList()
    }
    
    private func distributeTask() {
        guard let todoCollectionViewModel,
              let doingCollectionViewModel,
              let doneCollectionViewModel else {
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
