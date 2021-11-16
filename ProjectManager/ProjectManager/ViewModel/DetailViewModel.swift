//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/12.
//

import Foundation

class DetailViewModel: ObservableObject {
    private weak var managerViewmodel: ManagerViewModel?
    private weak var projectViewModel: ProjectViewModel?
    @Published var title: String
    @Published var selectedDate: Date
    @Published var content: String
    @Published var disabled: Bool
    
    init(_ projectViewModel: ProjectViewModel, title: String, selectedDate: Date, content: String) {
        self.projectViewModel = projectViewModel
        self.title = title
        self.selectedDate = selectedDate
        self.content = content
        self.disabled = true
    }
    
    init(_ managerViewModel: ManagerViewModel) {
        self.managerViewmodel = managerViewModel
        self.title = ""
        self.selectedDate = Date()
        self.content = ""
        self.disabled = false
    }
    
    func update() {
        projectViewModel?.update(title, selectedDate, content)
        
        guard let managerViewmodel = managerViewmodel else { return }
        let title = title == "" ? "제목" : title
        let content = content == "" ? "내용" : content
        let newProject = Project(title: title, content: content, dueDate: selectedDate)
        managerViewmodel.add(newProject)
    }
    
    var header: String {
        guard let status = projectViewModel?.project.status else { return "" }
        return status.header
    }
}
