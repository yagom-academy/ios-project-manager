//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

protocol PlanListViewModel {

    init(toDoList: [PlanViewModel], doingList: [PlanViewModel], doneList: [PlanViewModel])
    func bindToDoList(handler: @escaping ([PlanViewModel]) -> Void)
    func bindDoingList(handler: @escaping ([PlanViewModel]) -> Void)
    func bindDoneList(handler: @escaping ([PlanViewModel]) -> Void)
    func fetchList(of state: PlanState) -> [PlanViewModel]
    func addPlan(plan: Plan)
    func movePlan(to destination: PlanState, from origin: PlanState, index: Int)
    func removePlan(of state: PlanState, index: Int)
}

final class ProjectListViewModel: PlanListViewModel {

    var toDoList: [PlanViewModel] {
        didSet {
            toDoListHandler?(toDoList)
        }
    }
    var doingList: [PlanViewModel] {
        didSet {
            doingListHandler?(doingList)
        }
    }
    var doneList: [PlanViewModel] {
        didSet {
            doneListHandler?(doneList)
        }
    }
    private var toDoListHandler: (([PlanViewModel]) -> Void)?
    private var doingListHandler: (([PlanViewModel]) -> Void)?
    private var doneListHandler: (([PlanViewModel]) -> Void)?

    init(toDoList: [PlanViewModel], doingList: [PlanViewModel], doneList: [PlanViewModel]) {
        self.toDoList = toDoList
        self.doingList = doingList
        self.doneList = doneList
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

    func addPlan(plan: Plan) {
        let project = ProjectViewModel(plan: plan)
        toDoList.append(project)
    }

    func movePlan(to destination: PlanState, from origin: PlanState, index: Int) {
        guard let project = fetchPlan(of: origin, index: index) else {
            return
        }

        project.changeState(to: destination)
    }

    private func fetchPlan(of state: PlanState, index: Int) -> PlanViewModel? {
        let list = fetchList(of: state)
        guard list.isValid(index: index) else {
            return nil
        }
        return list[index]
    }

    func fetchList(of state: PlanState) -> [PlanViewModel] {
        switch state {
        case .toDo:
            return toDoList
        case .doing:
            return doingList
        case .done:
            return doneList
        }
    }

    func removePlan(of state: PlanState, index: Int) {
        var list = fetchList(of: state)
        guard list.isValid(index: index) else {
            return
        }
        list.remove(at: index)
    }

    private func changeList(of state: PlanState, to list: [PlanViewModel]) {
        switch state {
        case .toDo:
            toDoList = list
        case .doing:
            doingList = list
        case .done:
            doneList = list
        }
    }
}

