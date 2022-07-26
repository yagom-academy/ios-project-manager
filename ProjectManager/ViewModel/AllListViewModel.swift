//
//  AllListViewModel.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import Foundation

class AllListViewModel: ViewModelType {
    func showLists() -> [Task] {
        self.service.readTasks()
    }
}

class ListViewModel: ViewModelType {
    @Published var isShowingSheet = false
    @Published var isShowingPopover = false
    
    func toggleShowingSheet() {
        isShowingSheet.toggle()
    }
    
    func toggleShowingPopover() {
        isShowingPopover.toggle()
    }
    
    func moveTask(_ task: Task, to: TaskType) {
        self.service.moveTask(task, to: to)
    }
}
