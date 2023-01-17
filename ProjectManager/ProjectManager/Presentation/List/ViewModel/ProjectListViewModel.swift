//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

protocol PlanListViewModel {

    init(toDoList: [Project], doingList: [Project], doneList: [Project])
    func bindToDoList(handler: @escaping ([PlanViewModel]) -> Void)
    func bindDoingList(handler: @escaping ([PlanViewModel]) -> Void)
    func bindDoneList(handler: @escaping ([PlanViewModel]) -> Void)
    func fetchList(of state: State) -> [PlanViewModel]
}

final class ProjectListViewModel: PlanListViewModel {

    private var toDoList: [PlanViewModel] {
        didSet {
            toDoListHandler?(toDoList)
        }
    }
    private var doingList: [PlanViewModel] {
        didSet {
            doingListHandler?(doingList)
        }
    }
    private var doneList: [PlanViewModel] {
        didSet {
            doneListHandler?(doneList)
        }
    }
    private var toDoListHandler: (([PlanViewModel]) -> Void)?
    private var doingListHandler: (([PlanViewModel]) -> Void)?
    private var doneListHandler: (([PlanViewModel]) -> Void)?

    init(toDoList: [Project] = [], doingList: [Project] = [], doneList: [Project] = []) {
        self.toDoList = toDoList.map(ProjectViewModel.init)
        self.doingList = doingList.map(ProjectViewModel.init)
        self.doneList = doneList.map(ProjectViewModel.init)
    }

    func bindToDoList(handler: @escaping ([PlanViewModel]) -> Void) {
        self.toDoListHandler = handler
    }

    func bindDoingList(handler: @escaping ([PlanViewModel]) -> Void) {
        self.toDoListHandler = handler
    }

    func bindDoneList(handler: @escaping ([PlanViewModel]) -> Void) {
        self.toDoListHandler = handler
    }

    func configurePlanList(toDo: [Project], doing: [Project], done: [Project]) {
        self.toDoList = toDo.map(ProjectViewModel.init)
        self.doingList = doing.map(ProjectViewModel.init)
        self.doneList = done.map(ProjectViewModel.init)
    }

    func fetchList(of state: State) -> [PlanViewModel] {
        switch state {
        case .toDo:
            return toDoList
        case .doing:
            return doingList
        case .done:
            return doneList
        }
    }
}

