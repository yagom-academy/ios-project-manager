//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

final class ListViewModel {

    var listUseCase: ListUseCase {
        didSet {
            toDoList = listUseCase.fetchProjectList(state: .toDo)
            doingList = listUseCase.fetchProjectList(state: .doing)
            doneList = listUseCase.fetchProjectList(state: .done)
        }
    }
    private var toDoList: [Project] {
        didSet {
            toDoListHandler?(toDoList)
        }
    }
    private var doingList: [Project] {
        didSet {
            doingListHandler?(doingList)
        }
    }
    private var doneList: [Project] {
        didSet {
            doneListHandler?(doneList)
        }
    }
    private var toDoListHandler: (([Project]) -> Void)?
    private var doingListHandler: (([Project]) -> Void)?
    private var doneListHandler: (([Project]) -> Void)?

    init(listUseCase: ListUseCase) {
        self.listUseCase = listUseCase
        toDoList = listUseCase.fetchProjectList(state: .toDo)
        doingList = listUseCase.fetchProjectList(state: .doing)
        doneList = listUseCase.fetchProjectList(state: .done)
    }

    func bindToDoList(handler: @escaping ([Project]) -> Void) {
        self.toDoListHandler = handler
    }

    func bindDoingList(handler: @escaping ([Project]) -> Void) {
        self.toDoListHandler = handler
    }

    func bindDoneList(handler: @escaping ([Project]) -> Void) {
        self.toDoListHandler = handler
    }

    func fetchList(of state: State) -> [Project] {
        switch state {
        case .toDo:
            return toDoList
        case .doing:
            return doingList
        case .done:
            return doneList
        }
    }

    func convertToText(from project: Project) -> (title: String, description: String, deadline: String) {

        return (project.title, project.description, project.deadline.localeFormattedText)
    }
}

