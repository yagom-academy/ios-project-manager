//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/12.
//

import Foundation

class ListViewModel {
    private weak var managerViewModel: ManagerViewModel?
    private(set) var projects: [Project]
    private(set) var status: Project.Status
    
    init(managerViewModel: ManagerViewModel,projects: [Project], status: Project.Status) {
        self.managerViewModel = managerViewModel
        self.projects = projects
        self.status = status
    }
    
    func delete(at index: Int?) {
        managerViewModel?.delete(status, at: index)
    }
    
    var header: String {
        return status.header
    }
    
    var count: Int {
        return projects.count
    }
    
    func projectViewModel(_ project: Project) -> ProjectViewModel {
        return ProjectViewModel(self, project: project)
    }
    
    func update(_ newStatus: Project.Status, of projectID: UUID) {
        managerViewModel?.update(newStatus, of: projectID)
    }
    
    func update(_ project: Project, of projectID: UUID) {
        managerViewModel?.update(project, with: projectID)
    }
}
