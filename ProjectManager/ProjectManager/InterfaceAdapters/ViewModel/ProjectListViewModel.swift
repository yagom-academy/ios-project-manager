//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

protocol PlanListViewModel: OutputPort {

    init(toDoList: [Plan], doingList: [Plan], doneList: [Plan])
    func bindToDoList(handler: @escaping ([PlanViewModel]) -> Void)
    func bindDoingList(handler: @escaping ([PlanViewModel]) -> Void)
    func bindDoneList(handler: @escaping ([PlanViewModel]) -> Void)
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

    init(toDoList: [Plan], doingList: [Plan], doneList: [Plan]) {
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

    func configurePlanList(toDo: [Plan], doing: [Plan], done: [Plan]) {
        self.toDoList = toDo.map(ProjectViewModel.init)
        self.doingList = doing.map(ProjectViewModel.init)
        self.doneList = done.map(ProjectViewModel.init)
    }
}

