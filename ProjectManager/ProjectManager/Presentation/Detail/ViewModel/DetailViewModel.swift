//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

final class DetailViewModel {
    
    private var detailUseCase: DetailUseCase
    private let project: Project
    private let state: State
    private let isNewProject: Bool
    private(set) var isEditable: Bool {
        didSet {
            editHandler?(isEditable)
        }
    }
    
    private(set) var isValidText: Bool = true {
        didSet {
            textHandler?(isValidText)
        }
    }
    
    private var editHandler: ((Bool) -> Void)?
    private var textHandler: ((Bool) -> Void)?

    init(detailUseCase: DetailUseCase, project: Project, state: State = .toDo, isNewProject: Bool = false) {
        self.detailUseCase = detailUseCase
        self.project = project
        self.state = state
        self.isNewProject = isNewProject
        isEditable = isNewProject
    }

    func bindEditable(handler: @escaping (Bool) -> Void) {
        editHandler = handler
    }
    
    func bindValidText(handler: @escaping (Bool) -> Void) {
        textHandler = handler
    }
    
    func fetchNavigationTitle() -> String {
        switch state {
        case .toDo:
            return Text.toDoTitle
        case .doing:
            return Text.doingTitle
        case .done:
            return Text.doneTitle
        }
    }

    func changeEditable(state: Bool) {
        isEditable = state
    }
    
    func fetchValues() -> (title: String, description: String, deadline: Date) {
        return (project.title, project.description, project.deadline)
    }
    
    func fetchIdentifier() -> UUID? {
        guard !isNewProject else {
            return nil
        }
        return project.identifier
    }
    
    func validateDescription(text: String) {
        if isValidText != detailUseCase.isValidateDescription(text: text) {
            isValidText = detailUseCase.isValidateDescription(text: text)
        }
    }
    
    func validateDeadline(date: Date) -> Bool {
        return detailUseCase.isValidateDeadline(date: date)
    }
}

extension DetailViewModel {
    
    enum Text {
        
        static let toDoTitle: String = "TODO"
        static let doingTitle: String = "DOING"
        static let doneTitle: String = "DONE"
    }
}
