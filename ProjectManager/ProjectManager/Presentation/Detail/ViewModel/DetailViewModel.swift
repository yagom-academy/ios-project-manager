//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

final class DetailViewModel {
    
    typealias Text = Constant.Text

    private var detailUseCase: DetailUseCase
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

    init(detailUseCase: DetailUseCase, isNewProject: Bool = false) {
        self.detailUseCase = detailUseCase
        isEditable = isNewProject
    }

    func bindEditable(handler: @escaping (Bool) -> Void) {
        editHandler = handler
    }
    
    func bindValidText(handler: @escaping (Bool) -> Void) {
        textHandler = handler
    }
    
    func fetchNavigationTitle() -> String {
        switch detailUseCase.state {
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
        return (detailUseCase.fetchText(of: .title),
                detailUseCase.fetchText(of: .description),
                detailUseCase.fetchDeadline())
    }
    
    func validateDescription(text: String) {
        if isValidText != detailUseCase.isValidateDescription(text: text) {
            isValidText = detailUseCase.isValidateDescription(text: text)
        }
    }
    
    func validateDeadline(date: Date) -> Bool {
        return detailUseCase.isValidateDeadline(date: date)
    }
    
    func makeProject(title: String, description: String, deadline: Date) -> Project {
        let project = Project(title: title,
                              description: description,
                              deadline: deadline,
                              state: detailUseCase.state,
                              identifier: detailUseCase.fetchIdentifier())
        
        return project
    }
}
