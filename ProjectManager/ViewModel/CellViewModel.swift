//
//  CellViewModel.swift
//  ProjectManager
//
//  Created by marisol on 2022/07/20.
//

import SwiftUI

class CellViewModel: ViewModelType {
    @Published var isShowingSheet = false
    @Published var isShowingPopover = false
    @Published var task: Task
    
    init(withService: TaskManagementService, task: Task) {
        self.task = task
        super.init(withService: withService)
    }
    
    func toggleShowingSheet() {
        isShowingSheet.toggle()
    }
    
    func toggleShowingPopover() {
        isShowingPopover.toggle()
    }
}
