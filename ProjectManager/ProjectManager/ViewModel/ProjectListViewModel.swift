//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

final class ProjectListViewModel {

    private var toDoList: [ProjectViewModel] {
        didSet {
            toDoListHandler?(toDoList)
        }
    }
    private var doingList: [ProjectViewModel] {
        didSet {
            doingListHandler?(doingList)
        }
    }
    private var doneList: [ProjectViewModel] {
        didSet {
            doneListHandler?(doneList)
        }
    }
    private var toDoListHandler: (([ProjectViewModel]) -> Void)?
    private var doingListHandler: (([ProjectViewModel]) -> Void)?
    private var doneListHandler: (([ProjectViewModel]) -> Void)?

    init(toDoList: [ProjectViewModel], doingList: [ProjectViewModel], doneList: [ProjectViewModel]) {
        self.toDoList = toDoList
        self.doingList = doingList
        self.doneList = doneList
    }

    func bindToDoList(handler: @escaping ([ProjectViewModel]) -> Void) {
        self.toDoListHandler = handler
    }

    func bindDoingList(handler: @escaping ([ProjectViewModel]) -> Void) {
        self.toDoListHandler = handler
    }

    func bindDoneList(handler: @escaping ([ProjectViewModel]) -> Void) {
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

    private func fetchPlan(of state: PlanState, index: Int) -> ProjectViewModel? {
        let list = fetchList(of: state)
        guard list.isValid(index: index) else {
            return nil
        }
        return list[index]
    }

    private func fetchList(of state: PlanState) -> [ProjectViewModel] {
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

    private func changeList(of state: PlanState, to list: [ProjectViewModel]) {
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

