//
//  PopUpViewModel.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/12.
//

import Foundation

class PopOverViewModel: ObservableObject {
    private weak var projectViewModel: ProjectViewModel?
    private var status: Project.Status
    
    init(_ projectViewModel: ProjectViewModel, status: Project.Status) {
        self.projectViewModel = projectViewModel
        self.status = status
    }
    
    var popOverOptions: [Project.Status] {
        return status.theOthers
    }
    
    func update(_ newStatus: Project.Status) {
        projectViewModel?.update(newStatus)
    }
}
