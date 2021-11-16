//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/12.
//

import Foundation

class ProjectViewModel: ObservableObject {
    private weak var listViewModel: ListViewModel?
    @Published var tapped: Bool
    @Published var longPressed: Bool
    private(set) var project: Project
    
    init(_ listViewModel: ListViewModel?, project: Project, tapped: Bool = false, longPressed: Bool = false) {
        self.listViewModel = listViewModel
        self.project = project
        self.tapped = tapped
        self.longPressed = longPressed
    }
    
    var title: String {
        return project.title
    }
    
    var content: String {
        return project.content
    }
    
    var dueDate: String {
        return project.dueDate.formatted
    }
    
    var isExpired: Bool {
        return project.dueDate.isExpired
    }
    
    var detailViewModel: DetailViewModel {
        return DetailViewModel(self, title: project.title, selectedDate: project.dueDate, content: project.content)
    }
    
    var popOverViewModel: PopOverViewModel {
        return PopOverViewModel(self, status: project.status)
    }
    
    func update(_ newStatus: Project.Status) {
        listViewModel?.update(newStatus, of: project.id)
    }
    
    func update(_ title: String, _ selectedDate: Date, _ content: String) {
        let newProject = Project(id: project.id, title: title, content: content, dueDate: selectedDate, created: project.created, status: project.status)
        listViewModel?.update(newProject, of: project.id)
    }
}
