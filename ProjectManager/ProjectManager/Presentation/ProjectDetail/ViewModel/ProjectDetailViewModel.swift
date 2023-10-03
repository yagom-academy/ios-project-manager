//
//  ProjectDetailViewModel.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/24.
//

import Combine
import Foundation

protocol ProjectDetailViewModelInput {
    func viewDidLoad()
    func tapDoneButton(title: String?, body: String?, date: Date)
    func tapCancelButton()
    func tapEditButton()
}

protocol ProjectDetailViewModelOutput {
    var navigationTitle: String { get }
    var title: String? { get }
    var body: String? { get }
    var deadlineDate: Date { get }
    var hasProject: Bool { get }
    var isEditingPublisher: Published<Bool>.Publisher { get }
}

typealias ProjectDetailViewModel = ProjectDetailViewModelInput & ProjectDetailViewModelOutput

final class DefaultProjectDetailViewModel: ProjectDetailViewModel {
    
    // MARK: - Private ProPerty
    private let projectUseCase: ProjectUseCase
    private var project: Project?
    
    @Published private var isEditing: Bool
    
    // MARK: - Life Cycle
    init(projectUseCase: ProjectUseCase,
         project: Project?
    ) {
        self.projectUseCase = projectUseCase
        self.project = project
        self.isEditing = project == nil ? true : false
    }
    
    // OUTPUT
    var title: String? { project?.title }
    var body: String? { project?.body}
    var deadlineDate: Date {
        guard let deadlineDate = project?.deadline else {
            return Date()
        }
        
        return deadlineDate
    }
    var hasProject: Bool {
        return project == nil ? false : true
    }
    var isEditingPublisher: Published<Bool>.Publisher { $isEditing }
    var navigationTitle: String { project?.state.rawValue ?? "TODO" }
}

// MARK: - INPUT View event methods
extension DefaultProjectDetailViewModel {
    func viewDidLoad() { }
    
    func tapDoneButton(title: String?, body: String?, date: Date) {
        guard let title,
              let body,
              title.count != 0 else {
            return
        }
                
        if var project {
            project.title = title
            project.body = body
            project.deadline = date
            
            projectUseCase.storeProject(project)
        } else {
            let newProject = Project(title: title, body: body, deadline: date, state: .toDo)
            
            projectUseCase.storeProject(newProject)
        }
    }
    
    func tapCancelButton() { }
    
    func tapEditButton() {
        isEditing = true
    }
}
