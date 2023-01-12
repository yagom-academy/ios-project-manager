//
//  MainListViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

class MainListViewModel {
    // 메인에서 가져야할 데이터,,,,,,,,, 세개의 리스트,,
    private var todoList: [Work] = [] {
        didSet {
            todoListHandler?(todoList)
        }
    }
    
    private var doingList: [Work] = [] {
        didSet {
            doingListHandler?(doingList)
        }
    }
    
    private var doneList: [Work] = [] {
        didSet {
            doneListHandler?(doneList)
        }
    }
    
    private var todoListHandler: (([Work]) -> Void)?
    private var doingListHandler: (([Work]) -> Void)?
    private var doneListHandler: (([Work]) -> Void)?
    
    func bindTodoList(handler: @escaping ([Work]) -> Void) {
        todoListHandler = handler
    }
    
    func bindDoingList(handler: @escaping ([Work]) -> Void) {
        todoListHandler = handler
    }
    
    func bindDoneList(handler: @escaping ([Work]) -> Void) {
        todoListHandler = handler
    }
}
