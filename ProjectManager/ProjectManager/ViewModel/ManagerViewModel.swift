//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

class ManagerViewModel: ObservableObject {
    @Published private(set) var projects: [Project]
    @Published var addTapped: Bool
    
    init(projects: [Project] = [], addTapped: Bool = false) {
        self.projects = projects
        self.addTapped = addTapped
    }
    
    func listViewModel(of status: Project.Status) -> ListViewModel {
        let projects = projects.filter { $0.status == status }
        return ListViewModel(managerViewModel: self, projects: projects, status: status)
    }
    
    func popupOptions(of projectID: UUID) -> [Project.Status] {
        return project(with: projectID).status.theOthers
    }
}

extension ManagerViewModel {
    func add(_ project: Project) {
        projects.insert(project, at: .zero)
    }
    
    func project(with projectID: UUID) -> Project {
        for project in projects {
            if project.id == projectID {
                return project
            }
        }
        return Project()
    }
    
    func update(_ newStatus: Project.Status, of projectID: UUID) {
        for index in projects.indices {
            if projects[index].id == projectID {
                projects[index].update(newStatus)
                return
            }
        }
    }
    
    func update(_ newProject: Project, with projectID: UUID) {
        for index in projects.indices {
            if projects[index].id == projectID {
                projects[index] = newProject
                return
            }
        }
    }
    
    func delete(_ status: Project.Status, at index: Int?) {
        guard let index = index else { return }
        let projectID = projects.filter({ $0.status == status })[index].id
        
        for index in projects.indices {
            if projects[index].id == projectID {
                projects.remove(at: index)
                return
            }
        }
    }
}
