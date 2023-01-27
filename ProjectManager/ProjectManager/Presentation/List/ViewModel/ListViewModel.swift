//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

final class ListViewModel {
    
    typealias Text = Constant.Text

    var listUseCase: ListUseCase
    private var projectList: [Project] = [] {
        didSet {
            toDoListHandler?(fetchList(of: .toDo))
            doingListHandler?(fetchList(of: .doing))
            doneListHandler?(fetchList(of: .done))
        }
    }
    
    private var toDoListHandler: (([Project]) -> Void)?
    private var doingListHandler: (([Project]) -> Void)?
    private var doneListHandler: (([Project]) -> Void)?

    init(listUseCase: ListUseCase) {
        self.listUseCase = listUseCase
    }
    
    func bindToDoList(handler: @escaping ([Project]) -> Void) {
        self.toDoListHandler = handler
    }

    func bindDoingList(handler: @escaping ([Project]) -> Void) {
        self.doingListHandler = handler
    }

    func bindDoneList(handler: @escaping ([Project]) -> Void) {
        self.doneListHandler = handler
    }

    func fetchList(of state: State) -> [Project] {
        switch state {
        case .toDo:
            return projectList.filter { $0.state == .toDo }
        case .doing:
            return projectList.filter { $0.state == .doing }
        case .done:
            return projectList.filter { $0.state == .done }
        }
    }
    
    func fetchCount(of state: State) -> Int {
        return fetchList(of: state).count
    }
    
    private func fetchProject(state: State, index: Int) -> Project {
        return fetchList(of: state)[index]
    }

    func fetchTexts(state: State, index: Int) -> (title: String,
                                                   description: String,
                                                   deadline: String) {
        let project = fetchProject(state: state, index: index)
        
        return (project.title.isEmpty ? Text.cellTitleDefaultValue : project.title,
                project.description.isEmpty ? Text.cellDescriptionDefaultValue : project.description,
                project.deadline.localeFormattedText)
    }
    
    func isOverdue(state: State, index: Int) -> Bool {
        return fetchProject(state: state, index: index).deadline.isOverdue
    }
    
    func fetchIdentifier(state: State, index: Int) -> UUID {
        return fetchProject(state: state, index: index).identifier
    }
    
    func saveProject(title: String,
                     description: String,
                     deadline: Date,
                     identifier: UUID?) {
        guard let identifier = identifier else {
            addProject(title: title, description: description, deadline: deadline)
            return
        }
        editProject(title: title, description: description, deadline: deadline, identifier: identifier)
    }
    
    private func addProject(title: String,
                    description: String,
                    deadline: Date) {
        let project = listUseCase.makeProject(title: title,
                                              description: description,
                                              deadline: deadline,
                                              identifier: nil)
        
        projectList.append(project)
    }
    
    private func editProject(title: String,
                     description: String,
                     deadline: Date,
                     identifier: UUID) {
        let project = listUseCase.makeProject(title: title,
                                              description: description,
                                              deadline: deadline,
                                              identifier: identifier)
        projectList = listUseCase.editProject(list: projectList, project: project)
    }
    
    func moveProject(identifier: UUID, to state: State) {
        guard var project = projectList.filter({ $0.identifier == identifier }).first else {
            return
        }
        project.state = state
        projectList = listUseCase.editProject(list: projectList, project: project)
    }
    
    func removeProject(identifier: UUID) {
        guard let index = projectList.firstIndex(where: { $0.identifier == identifier }) else {
            return
        }
        projectList = listUseCase.removeProject(list: projectList, index: index)
    }
    
    func makeDetailViewModel(project: Project? = nil) -> DetailViewModel {
        let detailUsecase = DefaultDetailUseCase()
        guard let project = project else {
            return DetailViewModel(detailUseCase: detailUsecase, project: Project(), isNewProject: true)
        }
        return DetailViewModel(detailUseCase: detailUsecase, project: project)
    }
}
