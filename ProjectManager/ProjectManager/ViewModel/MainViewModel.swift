//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

class MainViewModel {
    
    let processTitles: [String] = [Process.todo.title, Process.doing.title, Process.done.title]
    var todoData: [Project] = [] {
        didSet {
            updateTodoData(todoData)
        }
    }
    var doingData: [Project] = [] {
        didSet {
            updateData(doingData)
        }
    }
    var doneData: [Project] = [] {
        didSet {
            updateData(doneData)
        }
    }
    
    var updateTodoData: (_ data: [Project]) -> Void = { _ in }
    var updateData: (_ data: [Project]) -> Void = { _ in }
}
