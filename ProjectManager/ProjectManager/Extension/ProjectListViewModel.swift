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
            doingListHandler?(toDoList)
        }
    }
    private var doneList: [ProjectViewModel] {
        didSet {
            doneListHandler?(toDoList)
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
}
